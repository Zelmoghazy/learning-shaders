#include <IMGUI/imgui.h>
#include <IMGUI/imgui_impl_glfw.h>
#include <IMGUI/imgui_impl_opengl3.h>

#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <fstream>
#include <sstream>


// Use the better GPU ?
#ifdef _WIN32
#include <windows.h>
extern "C" {
    __declspec(dllexport) DWORD NvOptimusEnablement = 0x00000001;       // Optimus: force switch to discrete GPU
    __declspec(dllexport) int AmdPowerXpressRequestHighPerformance = 1; //AMD
}
#endif

std::string readShaderSource(const std::string& filepath) 
{
    std::ifstream file(filepath);
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

GLuint compileShader(GLenum type, const std::string& source) 
{
    GLuint shader = glCreateShader(type);
    const char* src = source.c_str();
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    int success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        char infoLog[512];
        glGetShaderInfoLog(shader, 512, nullptr, infoLog);
        std::cerr << "Shader compilation error:\n" << infoLog << std::endl;
    }

    return shader;
}

GLuint createShaderProgram(const std::string& vertexSource, const std::string& fragmentSource) 
{
    GLuint vertexShader   = compileShader(GL_VERTEX_SHADER, vertexSource);
    GLuint fragmentShader = compileShader(GL_FRAGMENT_SHADER, fragmentSource);

    GLuint shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);

    int success;
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
    if (!success) {
        char infoLog[512];
        glGetProgramInfoLog(shaderProgram, 512, nullptr, infoLog);
        std::cerr << "Shader program linking error:\n" << infoLog << std::endl;
    }

    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    return shaderProgram;
}

int main(void) 
{
    if (!glfwInit()) {
        std::cerr << "Failed to initialize GLFW" << std::endl;
        return -1;
    }
    
    GLFWwindow* window = glfwCreateWindow(800, 600, "GLFW Shader Example", nullptr, nullptr);
    if (!window) {
        std::cerr << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    glewExperimental = GL_TRUE;
    if (glewInit() != GLEW_OK) {
        std::cerr << "Failed to initialize GLEW" << std::endl;
        return -1;
    }

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO &io = ImGui::GetIO();
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 330");

    ImGui::StyleColorsDark();


    std::string vertexSource   = readShaderSource("../vertex_shader.glsl");
    std::string fragmentSource = readShaderSource("../fragment_shader.glsl");
    GLuint shaderProgram       = createShaderProgram(vertexSource, fragmentSource);

    float vertices[] = {
        // positions    // texture coords
        -1.0f,  1.0f,  0.0f, 1.0f,
        -1.0f, -1.0f,  0.0f, 0.0f,
         1.0f, -1.0f,  1.0f, 0.0f,
         1.0f,  1.0f,  1.0f, 1.0f
    };
    unsigned int indices[] = {
        0, 1, 2,
        2, 3, 0
    };

    GLuint VAO, VBO, EBO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);

    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)(2 * sizeof(float)));
    glEnableVertexAttribArray(1);

    // Render loop
    while (!glfwWindowShouldClose(window)) 
    {
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
            glfwSetWindowShouldClose(window, true);

        glClear(GL_COLOR_BUFFER_BIT);

        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();
        
        glUseProgram(shaderProgram);

        float timeValue = (float)glfwGetTime();
        int timeLoc     = glGetUniformLocation(shaderProgram, "u_time");
        glUniform1f(timeLoc, timeValue);

        int resolutionLoc = glGetUniformLocation(shaderProgram, "u_resolution");
        glUniform2f(resolutionLoc, 800.0f, 600.0f);

        double mouseX, mouseY;
        glfwGetCursorPos(window, &mouseX, &mouseY);
        int mouseButtonState = glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS ? 1 : 0;
        int mouseLoc = glGetUniformLocation(shaderProgram, "u_mouse");
        glUniform3f(mouseLoc, (float)mouseX, (float)mouseY, (float)mouseButtonState);

        ImGui::Begin("Camera");
            static float zoom_level = 10.0f;
            ImGui::SliderFloat("zoom_level", &zoom_level, 10.0, 1000.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "zoom_level"), zoom_level);

            static float ro_x = 0.0f;
            ImGui::SliderFloat("ro_x", &ro_x, -10.0, 10.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "ro_x"), ro_x);

            static float ro_y = 0.0f;
            ImGui::SliderFloat("ro_y", &ro_y, -10.0, 10.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "ro_y"), ro_y);

            static float ro_z = 0.0f;
            ImGui::SliderFloat("ro_z", &ro_z, -10.0, 10.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "ro_z"), ro_z);

            static float lt_x = 0.0f;
            ImGui::SliderFloat("lt_x", &lt_x, 0.0, 1.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "lt_x"), lt_x);

            static float lt_y = 0.0f;
            ImGui::SliderFloat("lt_y", &lt_y, -1.0, 1.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "lt_y"), lt_y);

            static float lt_z = 0.0f;
            ImGui::SliderFloat("lt_z", &lt_z, -1.0, 1.0);
            glUniform1f(glGetUniformLocation(shaderProgram, "lt_z"), lt_z);
        ImGui::End();

        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        ImGui::Render();
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);

    glfwTerminate();
    
    return 0;
}
