import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class EightQueens extends JFrame
{

	private class ResultLabel extends JLabel
    {
        private class TimerListener
            implements ActionListener
        {

            public void actionPerformed(ActionEvent actionevent)
            {
                setVisible(!isVisible());
                if(isVisible() && --flashesRemaining <= 0)
                    flashIncrements.stop();
            }

            private TimerListener()
            {
            	super();
            }

        }


        public void announceResult(String s)
        {
            flashIncrements.stop();
            setVisible(false);
            setText(s);
            flashesRemaining = 5;
            setVisible(true);
            flashIncrements.start();
        }

        private final Color color;
        private Timer flashIncrements;
        private int flashesRemaining;
        public ResultLabel()
        {
        	super();
            color = Color.RED;
            flashIncrements = new Timer(500, new TimerListener());
            setText("");
            setForeground(color);
        }
    }

    private class RestartListener
        implements ActionListener
    {

        public void actionPerformed(ActionEvent actionevent)
        {
            if(queenCount == 8)
            {
                nWins++;
                resultLabel.announceResult("WIN");
            } else
            {
                nLosses++;
                resultLabel.announceResult("LOSS");
            }
            winsField.setText(Integer.toString(nWins));
            lossesField.setText(Integer.toString(nLosses));
            queenCount = 0;
            for(int i = 0; i < 8; i++)
            {
                for(int j = 0; j < 8; j++)
                    board[i][j].clear();

            }

        }

        private RestartListener()
        {
        	super();
        }

    }

    class RadioListener
        implements ActionListener
    {

        public void actionPerformed(ActionEvent actionevent)
        {
            if(actionevent.getSource() == alwaysButton)
                markSquares();
            else
                unmarkSquares();
        }

        final EightQueens this$0;

        RadioListener()
        {
        	super();
            this$0 = EightQueens.this;
        }
    }



    public EightQueens()
    {
        board = new Square[8][8];
        queenCount = 0;
        nWins = 0;
        nLosses = 0;
        setTitle("Eight Queens Puzzle");
        setSize(500, 300);
        setDefaultCloseOperation(3);
        createContents();
        setVisible(true);
    }

    private void createContents()
    {
        Container container = getContentPane();
        JPanel jpanel = new JPanel();
        jpanel.setLayout(new GridLayout(8, 8));
        for(int i = 0; i < 8; i++)
        {
            board[i] = new Square[8];
            for(int j = 0; j < 8; j++)
            {
                board[i][j] = new Square();
                jpanel.add(board[i][j]);
            }

        }

        JPanel board = new JPanel();
        JPanel controlPanel = new JPanel();
        board.setLayout(new GridLayout(11, 1));
        controlPanel.setLayout(new FlowLayout());
        controlPanel.add(new JLabel("Controls"));
        board.add(controlPanel);
        board.add(new JPanel());
        JPanel jpanel3 = new JPanel();
        jpanel3.setLayout(new FlowLayout());
        jpanel3.add(new JLabel("Show Unsafe Spaces:"));
        board.add(jpanel3);
        RadioListener radiolistener = new RadioListener();
        alwaysButton = new JRadioButton("Always", true);
        alwaysButton.addActionListener(radiolistener);
        board.add(alwaysButton);
        onPressButton = new JRadioButton("When Mouse Pressed");
        onPressButton.addActionListener(radiolistener);
        board.add(onPressButton);
        ButtonGroup buttongroup = new ButtonGroup();
        buttongroup.add(alwaysButton);
        buttongroup.add(onPressButton);
        JButton jbutton = new JButton("Start Over");
        jbutton.addActionListener(new RestartListener());
        JPanel jpanel4 = new JPanel(new FlowLayout());
        jpanel4.add(jbutton);
        board.add(jpanel4);
        JLabel jlabel = new JLabel("Last Result: ");
        JPanel jpanel5 = new JPanel(new GridLayout(1, 2));
        resultLabel = new ResultLabel();
        jpanel5.add(jlabel);
        jpanel5.add(resultLabel);
        board.add(jpanel5);
        JLabel jlabel1 = new JLabel("Wins: ");
        winsField = new JTextField(5);
        winsField.setText(Integer.toString(nWins));
        winsField.setEditable(false);
        JPanel jpanel6 = new JPanel(new FlowLayout());
        jpanel6.add(jlabel1);
        jpanel6.add(winsField);
        board.add(jpanel6);
        JLabel jlabel2 = new JLabel("Losses: ");
        lossesField = new JTextField(5);
        lossesField.setText(Integer.toString(nLosses));
        lossesField.setEditable(false);
        JPanel jpanel7 = new JPanel(new FlowLayout());
        jpanel7.add(jlabel2);
        jpanel7.add(lossesField);
        board.add(jpanel7);
        container.setLayout(new BorderLayout());
        container.add(jpanel, "Center");
        container.add(board, "East");
    }

    void unmarkSquares()
    {
        for(int i = 0; i < 8; i++)
        {
            for(int j = 0; j < 8; j++)
                if(board[i][j].getState() == squareState.UNSAFE)
                    board[i][j].setBackground(null);

        }

    }

    void markSquares()
    {
        for(int i = 0; i < 8; i++)
        {
            for(int j = 0; j < 8; j++)
                if(board[i][j].getState() == squareState.QUEEN)
                    markSquaresForOneQueen(i, j);

        }

    }

    void markSquaresForOneQueen(int i, int j)
    {
        for(int k = 0; k < 8; k++)
            board[k][j].markUnsafe();

        for(int i1 = 0; i1 < 8; i1++)
            board[i][i1].markUnsafe();

        int l = Math.max(0, i - j);
        for(int j1 = Math.max(0, j - i); l < 8 && j1 < 8; j1++)
        {
            board[l][j1].markUnsafe();
            l++;
        }

        l = Math.min(7, i + j);
        for(int k1 = Math.max(0, (j + i) - 7); l >= 0 && k1 < 8; k1++)
        {
            board[l][k1].markUnsafe();
            l--;
        }

    }

    public static void main(String args[])
    {
        new EightQueens();
    }
    
    public static enum squareState{
        SAFE, UNSAFE, QUEEN;
      }
    

    private static ImageIcon QueenIcon = new ImageIcon("queen-icon.jpeg");
    public static final int sideLength = 8;
    private Square board[][];
    private int queenCount;
    private int nWins;
    private int nLosses;
    private JRadioButton alwaysButton;
    private JRadioButton onPressButton;
    private ResultLabel resultLabel;
    private JTextField winsField;
    private JTextField lossesField;
    
    private class Square extends JButton
    {
        class Listener extends MouseAdapter
        {

            public void mousePressed(MouseEvent mouseevent)
            {
                if(state == squareState.UNSAFE && onPressButton.isSelected())
                    setBackground(Color.RED);
            }

            public void mouseReleased(MouseEvent mouseevent)
            {
                if(state == squareState.UNSAFE && onPressButton.isSelected())
                    setBackground(null);
                if(state == squareState.SAFE)
                {
                    state = squareState.QUEEN;
                    setIcon(EightQueens.QueenIcon);
                    queenCount++;
                    markSquares();
                }
            }

            final Square this$1;

            Listener()
            {
            	super();
                this$1 = Square.this;
            }
        }


        public squareState getState()
        {
            return state;
        }

        public void clear()
        {
            setIcon(null);
            state = squareState.SAFE;
            setBackground(null);
        }

        public void markUnsafe()
        {
            if(state != squareState.QUEEN)
            {
                state = squareState.UNSAFE;
                if(alwaysButton.isSelected())
                    setBackground(Color.RED);
            }
        }

        protected void paintComponent(Graphics g)
        {
            g.setColor(getBackground());
            g.fillRect(0, 0, getWidth(), getHeight());
            super.paintComponent(g);
        }

        private static final long serialVersionUID = 1L;
        private squareState state;
        final EightQueens this$0;



        public Square()
        {
        	super();
            this$0 = EightQueens.this;
            state = squareState.SAFE;
            super.setContentAreaFilled(false);
            addMouseListener(new Listener());
        }
    }
    
}
