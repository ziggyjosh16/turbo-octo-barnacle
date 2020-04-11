 
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton; 
 

@SuppressWarnings("serial")
public class program11  extends JFrame {
	program11() {
		this.setTitle("Tic Tac Toe");
		this.setBounds(0, 0, 600, 600); 
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
	
	public static void main(String[] args) throws IOException { 
		JFrame frame = new program11();
		frame.setLayout(new BorderLayout());
		
		
		// create a panel with box layer aligned with y axis
		JPanel yPanel= new JPanel();
		yPanel.setLayout(new BoxLayout(yPanel, BoxLayout.Y_AXIS));
		JPanel statPanel= new JPanel();
		statPanel.setLayout(new GridLayout(1,3));
		// create a new game button that is centered on x axis
		JButton newGame= new JButton("New Game");
		newGame.setAlignmentX(Component.CENTER_ALIGNMENT);

		JRadioButton xFirst= new JRadioButton("X:", true);
		JRadioButton oFirst= new JRadioButton("O:");
		JLabel first= new JLabel("First move");
		ButtonGroup group= new ButtonGroup();
		group.add(xFirst);
		group.add(oFirst);
		
		JLabel xWins= new JLabel("X: " );
		JLabel oWins= new JLabel("0: " );
		JLabel draws= new JLabel("Draws: ");
		JRadioButton[] selects= {xFirst, oFirst};
		JLabel[] labels= {xWins, oWins, draws};
		statPanel.add(xWins);
		statPanel.add(oWins);
		statPanel.add(draws);

		// add the new game button to the game panel
		yPanel.add(newGame);
		yPanel.add(first);
		yPanel.add(xFirst);
		yPanel.add(oFirst);
		
		// create a box panel with 3 x 3 grid layout
		JPanel boxPanel= new JPanel(new GridLayout(3,3));
		// create an array of 9 buttons and add them to the box panel
		JButton[] GameBoard= new JButton[9];
		for (int i=0; i<9; i++){
			GameBoard[i]=new JButton();
			boxPanel.add(GameBoard[i]);
		}
		// instantiate a tic-tac-toe game object 
		TicTacToe ticTacToe= new TicTacToe(GameBoard, selects, labels);
		
		// add an action listener to the new-game button so that it clears the game on click.
		newGame.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				ticTacToe.clear();
				ticTacToe.addListener();
				ticTacToe.controlListener();
				
			}
		});
		// add game panel (north) and box panel (center) to the frame and set it visible
		frame.add(yPanel, BorderLayout.NORTH);
		frame.add(boxPanel, BorderLayout.CENTER);
		frame.add(statPanel, BorderLayout.SOUTH);
		
		frame.setVisible(true);
	}
}

class TicTacToe {
	int[] data = new int[9];
	JButton[] buttons;
	boolean isX;
	JRadioButton[] selects; 
	JLabel[] labels;
	int xwins=0;
	int owins=0;
	int draws=0;
	// this variable keeps track of how many steps the game has played (it cannot be >= 9)
	int steps = 0;

	// use the flag to indicate whether the game has ended due to that X wins or O wins but not due to a draw
	boolean gameEnded = true;
	
	ImageIcon icon_x, icon_o; 
	
	// save buttons, load icon images, and clear the game (by calling "clear" method)
	TicTacToe(JButton[] buttons, JRadioButton[] selects, JLabel[] labels) throws IOException {
		this.buttons = buttons; 
		this.selects= selects;
		this.labels=labels;
		icon_x = new ImageIcon(ImageIO.read(getClass().getResource("X.png")));
		icon_o = new ImageIcon(ImageIO.read(getClass().getResource("O.png"))); 
		clear(); 
		addListener();
		controlListener();
	} 
	//Action listener for RadioButtons
	void controlListener(){
		selects[0].setEnabled(true);
		selects[1].setEnabled(true);
		if (selects[0].isSelected()){
			isX=true;
		}
		else if (selects[1].isSelected()){
			isX=false;
		}
	selects[0].addActionListener(new ActionListener(){
			
			public void actionPerformed(ActionEvent e){
				isX=true;
			}
		});
		
		selects[1].addActionListener(new ActionListener(){
			
			public void actionPerformed(ActionEvent e){
				isX=false;
			}
		});
	}
	void disable(){
		selects[0].setEnabled(false);
		selects[1].setEnabled(false);
	}
	
	// add the same listener to all buttons
	void addListener() {
		for (int j=0; j<buttons.length; j++){
			buttons[j].addActionListener(buttonListener);
		}	
	
	}

	// create an action listener
	ActionListener buttonListener = new ActionListener() {
		// 1. Use the event source to find out which button is clicked
		// 2. Find out if anyone wins and if so, has it X or O player won
		// 3. In the console, 
		//      if X wins, print "X wins", 
		//      if O wins, print "O wins", 
		//      if it is a draw (max number of steps has reached), print "Draw" 
		//      if nobody wins, do nothing and continue the game
		// 4. Don't forget to increment the "steps" variable to find out whether max number of steps has reached.
		// 5. Switch player in this method as well if it is a legal move.
		@Override
		public void actionPerformed(ActionEvent e){
			disable();
			Object src = e.getSource();
			int i=0;
				for(int j=0; j<buttons.length; j++){
					if (src == buttons[j]){
						i=j;
						break;
					}
				}
				if(play(i,isX))
				{
					int num= win();
					steps= steps+1;	
					if(num==1){
						//set text to x wins
						System.out.println("X wins");
						xwins= xwins+ 1;
						labels[0].setText("X: " + xwins);
					}
					else if(num==2){
						//set text to o wins
						System.out.println("O wins!");
						owins= owins+1;
						labels[1].setText("0: " + owins);


					}
					else if(steps==9){
						//set test to a draw
						removeListener();
						System.out.println("Draw");
						draws= draws+1;
						labels[2].setText("Draws: " + draws);

					}
					isX = !isX;
				}
			}
	};
	
	// reset "steps" to 0
	// for each button, set the background color to "white" and remove icons from buttons "setIcon(null)"
	// reset "data" array to 0
	// if game has ended (due to someone winnning), add listener back to buttons and reset the flag to false
	void clear() {
		steps=0;
		for(int j=0; j<buttons.length; j++){
			buttons[j].setIcon(null);
			buttons[j].setBackground(Color.white);
		}
		for(int i=0; i<data.length; i++){
			data[i]=0;
		}
		if (gameEnded){
			gameEnded=false;
		}
	}
		
	
	// remove listener from all buttons and set "gameEnded" flag to true
	void removeListener() {
		for (int j=0; j<buttons.length; j++){
			buttons[j].removeActionListener(buttonListener);
		}
		gameEnded=true;
	}
	
	// put X or O at i
	// if a button click is legal (i.e. the button was no clicked before), set icons to the button and update "data" array accordingly
	// return true if and only if the button click is legal
	boolean play(int i, boolean isX) {
		boolean ret = false;
		if(data[i] == 0) {
			if(isX) {
				data[i] = 1;
				buttons[i].setIcon(icon_x);
			}
			else {
				data[i] = 2;
				buttons[i].setIcon(icon_o);
			}
			ret = true;
		}
		return ret;
	} 
	// if X wins, return 1, 
	// if O wins, return 2, 
	// if draws or no result, return 0
	//
	// if someone wins, the remove listeners so that subsequent clicks won't change the remaining unclicked buttons
	int win() {
		int ret = 0;
		
		for(int i=0; i<3; i++) {
			ret = checkRow(i);
			if(ret != 0) {
				break;
			}
			ret = checkColumn(i);
			if(ret != 0) {
				break;
			}
		}
		if(ret == 0) {
			ret = checkDiagonal();
		}
		if(ret != 0) {
			removeListener();
		}
		return ret;
	}

	// check whether the ith row matches
	//       if so, set the background for that row of buttons to blue color
	//       and also return 1 if X wins, 2 if O wins, 0 if nobody wins
	int checkRow(int i){
		i=i*3;
		int b=i+1;
		int c=i+2;		
		
		if (data[i]==1 && data[b]==1 && data[c]==1){
			int[] indices=  {i, b, c};
			setBackground(indices);
			return 1;
		}
		else if(data[i]==2 && data[b]==2 && data[c]==2){
			int[] indices=  {i, b, c};
			setBackground(indices);
			return 2;
		}
		else{
			return 0;
		}
	}
	// check whether the ith column matches
	//       if so, set the background for that column of buttons to blue color
	//       and also return 1 if X wins, 2 if O wins, 0 if nobody wins
	int checkColumn(int i) {
		int b=i+3;
		int c=i+6;		
		if (data[i]==1 && data[b]==1 && data[c]==1){
			int[] indices=  {i, b, c};
			setBackground(indices);
			return 1;
		}
		if(data[i]==2 && data[b]==2 && data[c]==2){
			int[] indices=  {i, b, c};
			setBackground(indices);
			return 2;
		}
		else{
			return 0;
		}
	} 

	// check whether a diagonal matches
	//       if so, set the background for that diagonal of buttons to blue color
	//       and also return 1 if X wins, 2 if O wins, 0 if nobody wins
	// note that there are two diagonals to check
	int checkDiagonal() {
		if (data[0] == 1 && data[4]==1 && data[8]==1){
			int[]indices = {0,4,8};
			setBackground(indices);
			return 1;
		}
		if (data[2] == 1 && data[4]==1 && data[6]==1){
			int[]indices = {2,4,6};
			setBackground(indices);
			return 1;
		}
		if (data[0] == 2 && data[4]==2 && data[8]==2){
			int[]indices = {0,4,8};
			setBackground(indices);
			return 2;
		}
		if (data[2] == 2 && data[4]==2 && data[6]==2){
			int[]indices = {2,4,6};
			setBackground(indices);
			return 2;
		}
		else{
			return 0;
		}
	}
	// set buttons at the specified indices to blue
	void setBackground(int[] indices) {
		for (int i=0; i<indices.length; i++){
			buttons[indices[i]].setBackground(Color.BLUE);
	}
}
	
}



