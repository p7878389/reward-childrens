# How to Import into Figma

You can convert this high-fidelity prototype into editable Figma designs using the following steps.

## Option 1: One-Click Import (Recommended)

This method captures the exact visual rendering of your HTML/CSS.

1.  **Start Local Server**:
    Open your terminal in this project folder and run:
    ```bash
    ./start-server.sh
    ```
    *(Keep the terminal open)*

2.  **Open Figma**:
    Create a new design file.

3.  **Run Plugin**:
    - Search for the **"html.to.design"** plugin in Figma Community.
    - Run the plugin.

4.  **Import Pages**:
    In the plugin URL field, enter the following URLs to capture the key screens:
    
    *   **Home**: `http://localhost:8080/index.html`
    *   **Manage**: `http://localhost:8080/child-manage.html`
    *   **History**: `http://localhost:8080/points-history.html`
    *   **Store**: `http://localhost:8080/rewards-store.html`

    *Tip: Set the "View" in the plugin to Mobile (e.g., 375px width) for best results.*

## Option 2: Using Design Tokens

If you want to set up your Figma library variables automatically.

1.  **Run Plugin**:
    - Search for **"Tokens Studio for Figma"** (formerly Figma Tokens).
    - Run the plugin.

2.  **Load File**:
    - In the plugin, look for "Load from file" or "Import".
    - Select the `design-tokens.json` file generated in this project.

3.  **Apply**:
    - This will automatically create your Color Styles, Border Radius, and Shadows in Figma!
