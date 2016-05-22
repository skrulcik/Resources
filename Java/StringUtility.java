package edu.cmu.cs.cs214.hw6.util;

/**
 * Convenience functions for working with strings.
 */
public class StringUtility {

  /**
   * Node.js lol
   *
   * @param s Base string.
   * @param target Minimum length of output.
   * @return {@code s} if it is at least the size of target, or {@code s} prefixed by enough spaces
   * to make it the size of target.
   */
  public static String leftPad(String s, int target) {
    return leftPad(s, target, ' ');
  }

  /**
   * Node.js lol
   *
   * @param s Base string.
   * @param target Minimum length of output.
   * @param pad Character to pad the left side of the string with.
   * @return {@code s} if it is at least the size of target, or {@code s} prefixed by enough pad
   * characters to make it the size of target.
   */
  public static String leftPad(String s, int target, char pad) {
    StringBuilder sb = new StringBuilder();
    for (int i = s.length(); i < target; i++) {
      sb.append(pad);
    }
    sb.append(s);
    return sb.toString();
  }

  /**
   * Takes in a (possibly multi-line) string, and returns an "align-center" version with a fixed
   * width. The algorithm respects existing newlines and adds others where necessary. You can think
   * of it as automatically breaking lines, but treating existing newline characters as a paragraph
   * breaks. Assumes monospace font.
   *
   * @param s Initial string.
   * @param width Maximum width of output (> 0);
   * @return A center-aligned version of s abiding by the provided maximum width.
   */
  public static String centerText(String s, int width) {
    if (width < 1) {
      throw new IllegalArgumentException();
    }
    /* Split by newline characters to respect existing paragraph boundaries. */
    String[] paragraphs = s.split("\n");
    StringBuilder sb = new StringBuilder();
    for (String para : paragraphs) {
      /* Center each paragraph (possibly breaking lines) */
      sb.append(centerParagraph(para, width));
      sb.append("\n");
    }
    return sb.toString();
  }

  /**
   * Takes in a single string of text that is NOT broken in to newlines, and returns a center
   * aligned version that /may/ be broken into multiple lines.
   *
   * @param s Initial string.
   * @param width Maximum width of output (> 0);
   * @return A center-aligned version of s abiding by the provided maximum width.
   */
  public static String centerParagraph(String s, int width) {
    if (s.contains("\n")) {
      throw new IllegalArgumentException();
    }
    if (width < 1) {
      throw new IllegalArgumentException();
    }
    /* If the string fits on one line, left pad with spaces to approximate center.*/
    if (s.length() <= width) {
      return leftPad(s, width / 2 + s.length() / 2 + s.length() % 2);
    }

    /* Break a long string into multiple lines to enforce the width restriction. */
    int numLines = s.length() / width + 1;
    int extraChars = (numLines * width) % s.length();
    int lineWidth = extraChars > numLines ? width - extraChars / numLines:width;
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < numLines; i++) {
      int start = i * lineWidth;
      int end = Integer.min(start + lineWidth, s.length());
      /* Should use the base case of this function to format substring as a single line. */
      assert(centerParagraph(s.substring(start, end).trim(), width).length() <= width);
      sb.append(centerParagraph(s.substring(start, end).trim(), width));
      sb.append("\n");
    }
    return sb.toString();
  }

  /**
   * Determines whether the singular or plural version of a word should be used.
   *
   * @param val Number to be tested.
   * @param singular Singular form of the value description.
   * @param plural Plural form of the value description.
   * @return Singular form of the description if {@code val} is 1, the plural form otherwise.
   */
  public static String pluralize(long val, String singular, String plural) {
      return (val == 1) ? singular:plural;
  }
}
