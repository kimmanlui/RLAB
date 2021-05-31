package stock;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public class ReadXML {


  public static void main(String[] args) {
     ReadXML readxml=new ReadXML(); 
     readxml.getTagValue("config.xml", "dir");      
  }

  public String getTagValue(String filename , String xpath) {

      // Instantiate the Factory
      DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      String value="";
      try {
          // parse XML file
          DocumentBuilder db = dbf.newDocumentBuilder();

          Document doc = db.parse(new File(filename));

          // optional, but recommended
          // http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
          //doc.getDocumentElement().normalize();

          value=doc.getElementsByTagName("dir").item(0).getTextContent();
   
          System.out.println(value);

      } catch (ParserConfigurationException | SAXException | IOException e) {
          e.printStackTrace();
      }
      return value;

  }

}