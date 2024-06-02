import subprocess
import shutil
import os

# Function to run Git commands
def run_git_commands(commands):
    for command in commands:
        try:
            subprocess.run(command, check=True)
            print(f"Git command {' '.join(command)} executed successfully.")
        except subprocess.CalledProcessError as e:
            print(f"An error occurred while running git command {' '.join(command)}: {e}")
            raise

# Function to copy README.md to another folder
def copy_readme(destination_folder):
    if not os.path.exists(destination_folder):
        os.makedirs(destination_folder)
    shutil.copy('README.md', os.path.join(destination_folder, 'README.md'))
    print(f"README.md copied to {destination_folder} successfully.")

# Function to check if there are any changes to commit
def has_changes_to_commit():
    try:
        result = subprocess.run(['git', 'status', '--porcelain'], capture_output=True, text=True)
        return result.stdout.strip() != ''
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while checking for changes: {e}")
        return False

# Main function to execute the steps
def main():
    repo_path = 'C:/SQL/work/DBProject_315689042_314695438'
    
    # Verify if the repository path exists
    if os.path.exists(repo_path):
        os.chdir(repo_path)
    else:
        print(f"Repository path '{repo_path}' does not exist.")
        return

    # Commit and push changes to the main repository
    if has_changes_to_commit():
        try:
            run_git_commands([
                ['git', 'add', '.'],
                ['git', 'commit', '-m', 'Commit all changes'],
                ['git', 'pull', '--rebase'],
                ['git', 'push', 'origin', 'main']
            ])
        except subprocess.CalledProcessError:
            print("An error occurred during commit and push of the main changes.")
            return
    else:
        print("No changes to commit in the main repository.")
    
    # Copy README.md to Stage.1 folder
    copy_readme('Stage.1')
    
    # Check if there are any changes to commit in the Stage.1 folder
    if has_changes_to_commit():
        # Commit and push the copied file in the Stage.1 folder
        try:
            run_git_commands([
                ['git', 'add', 'Stage.1/README.md'],
                ['git', 'commit', '-m', 'Copy updated README.md to Stage.1 folder'],
                ['git', 'pull', '--rebase'],
                ['git', 'push', 'origin', 'main']
            ])
        except subprocess.CalledProcessError:
            print("An error occurred during commit and push of the README.md in Stage.1 folder.")
    else:
        print("No changes to commit in the Stage.1 folder.")

if __name__ == "__main__":
    main()
