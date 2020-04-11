
 
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame; 
import javax.swing.JPanel;
 

@SuppressWarnings("serial")
public class program09  extends JFrame {
	program09() {
		this.setTitle("Tic Tac Toe");
		this.setBounds(0, 0, 600, 600); 
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
	
	public static void main(String[] args) throws IOException { 
		// create a frame with border layout
		JFrame frame = new program09();
		frame.setLayout(new BorderLayout());
		
		// create a panel with box layer aligned with y axis
		JPanel yPanel= new JPanel();
	
		// create a new game button that is centered on x axis
		JButton newGame= new JButton("New Game");
		// add the new game button to the game panel
		frame.add(newGame, BorderLayout.PAGE_START);
		// create a box panel with 3 x 3 grid layout
		JPanel boxPanel= new JPanel(new GridLayout(3,3));
		// create an array of 9 buttons and add them to the box panel
		JButton[] GameBoard= new JButton[9];
		for (int i=0; i<9; i++){
			boxPanel.add(GameBoard[i]);
		}
		// instantiate a tic-tac-toe game object 
		TicTacToe ticTacToe= new TicTacToe(GameBoard);
		
		// add an action listener to the new-game button so that it clears the game on click.
		ActionListener clear= new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				ticTacToe.clear();
			}
		};
		// add game panel (north) and box panel (center) to the frame and set it visible
		frame.add(boxPanel, BorderLayout.CENTER);
		frame.setVisible(true);


		// TODO: Uncomment the line below for testing
// Testing.test(frame, buttons, newGame, game);
		
	}
}

class TicTacToe {
	// this array holds flags for buttons
	//   0 means not clicked
	//   1 means X
	//   2 means O
	int[] data = new int[9];

	// array of buttons representing the grid cells of the game
	JButton[] buttons;

	// this means next move will be X if true and O if false
	boolean isX = true; 
		
	// save buttons array
	// load icons
	// clear the grid (call the clear method)
	// add listener (call the addListener method)
	TicTacToe(JButton[] buttons) throws IOException {
	try{
		ImageIcon icon_o= new ImageIcon(ImageIO.read(getClass().getResource("O.png")));
		ImageIcon icon_x= new ImageIcon(ImageIO.read(getClass().getResource("X.png")));
		this.clear();
		this.addListener();
	}
	catch (Exception E){
		System.out.println(E.getClass() + ":\n" + E.getMessage());
	}
	}
	 
	// add action the same button listener to all buttons
	private void addListener() {
		for (JButton j: buttons){
			j.addActionListener(buttonListener);
		}
	}

	// create a button listener object directly from ActionListener interface
	// by overridding its actionPerformed method
	//
	// the actionPerformed method will find out 
	//              which button is clicked and 
	//              whether the click is successful and switch the player if so
	ActionListener buttonListener = new ActionListener() {
		@Override
		public void actionPerformed(ActionEvent e) {
			
		}
	};
	
	// set the background color to each button to white 
	// remove icons by calling setIcon(null)
	// clear the data array to 0
	// reset isX to true
	void clear() {
		this.isX=true;
		for(JButton j: buttons){
			j.setIcon(null);
			j.setBackground(Color.white);
		}
		for(int i: data){
			i=0;
		}
	}
	  
	// put X or O at the i'th button
	// set the data array to 1 for X and 2 for O
	//
	// returns true if i'th button is not already clicked
	private boolean play(int i, boolean isX) {
		
	}  
}

