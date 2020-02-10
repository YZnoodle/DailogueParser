# Godot json dialogue parser
This dialogue manager created in Godot is reusable and allows quick creation of mini games.

<img src="https://github.com/YZnoodle/DailogueParser/blob/master/resource/DialogueDemo.gif" width="400" />

**How to use**  
1. Instance a dialogue manager  
2. Add dialogue manager to tree  
3. Call dialogue manager with the conversation’s json file path  
4. (Optional) If there are method calls associated with options, a signal call_emitted() will be emitted, first argument is a string of the method name. Method need to be handled outside the dialogue manager.  
Then user clicks and clicks until conversation is over…  
Repeat step 3 and 4 for a new conversation. 

More info:
[https://yznoodle.github.io/Dialogue-Manager-and-Parser/](https://yznoodle.github.io/Dialogue-Manager-and-Parser/)

