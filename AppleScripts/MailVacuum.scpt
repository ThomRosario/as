FasdUAS 1.101.10   ��   ��    k             l      ��  ��   SM
Speed up Mail.app by vacuuming the Envelope Index
Code from: http://www.hawkwings.net/2007/03/03/scripts-to-automate-the-mailapp-envelope-speed-trick/
Originally by "pmbuko" with modifications by Romulo
Updated by Brett Terpstra 2012
Updated by Mathias T�rnblom 2015 to support V3 in El Capitan and still keep backwards compability
     � 	 	� 
 S p e e d   u p   M a i l . a p p   b y   v a c u u m i n g   t h e   E n v e l o p e   I n d e x 
 C o d e   f r o m :   h t t p : / / w w w . h a w k w i n g s . n e t / 2 0 0 7 / 0 3 / 0 3 / s c r i p t s - t o - a u t o m a t e - t h e - m a i l a p p - e n v e l o p e - s p e e d - t r i c k / 
 O r i g i n a l l y   b y   " p m b u k o "   w i t h   m o d i f i c a t i o n s   b y   R o m u l o 
 U p d a t e d   b y   B r e t t   T e r p s t r a   2 0 1 2 
 U p d a t e d   b y   M a t h i a s   T � r n b l o m   2 0 1 5   t o   s u p p o r t   V 3   i n   E l   C a p i t a n   a n d   s t i l l   k e e p   b a c k w a r d s   c o m p a b i l i t y 
   
  
 l     ��������  ��  ��        l    
 ����  O    
    I   	������
�� .aevtquitnull��� ��� null��  ��    m       �                                                                                  emal  alis    N  rosartl1-ml2-hd            �9��H+  ���Mail.app                                                       �ă���        ����  	                Applications    �9�      ���    ���  &rosartl1-ml2-hd:Applications: Mail.app    M a i l . a p p     r o s a r t l 1 - m l 2 - h d  Applications/Mail.app   / ��  ��  ��        l    ����  r        I   �� ��
�� .sysoexecTEXT���     TEXT  m       �   . s w _ v e r s   - p r o d u c t V e r s i o n��    o      ���� 0 
os_version  ��  ��        l    ����  r        m       �      V 2  o      ���� 0 mail_version  ��  ��     ! " ! l   * #���� # P    * $ %�� $ Z   ) & '���� & B     ( ) ( m     * * � + + 
 1 0 . 1 0 ) o    ���� 0 
os_version   ' r   " % , - , m   " # . . � / /  V 3 - o      ���� 0 mail_version  ��  ��   % ����
�� consnume��  ��  ��  ��   "  0 1 0 l     ��������  ��  ��   1  2 3 2 l  + 6 4���� 4 r   + 6 5 6 5 I  + 4�� 7��
�� .sysoexecTEXT���     TEXT 7 b   + 0 8 9 8 b   + . : ; : m   + , < < � = = 0 l s   - l n a h   ~ / L i b r a r y / M a i l / ; o   , -���� 0 mail_version   9 m   . / > > � ? ? p / M a i l D a t a   |   g r e p   - E   ' E n v e l o p e   I n d e x $ '   |   a w k   { ' p r i n t   $ 5 ' }��   6 o      ���� 0 
sizebefore 
sizeBefore��  ��   3  @ A @ l  7 @ B���� B I  7 @�� C��
�� .sysoexecTEXT���     TEXT C b   7 < D E D b   7 : F G F m   7 8 H H � I I @ / u s r / b i n / s q l i t e 3   ~ / L i b r a r y / M a i l / G o   8 9���� 0 mail_version   E m   : ; J J � K K @ / M a i l D a t a / E n v e l o p e \   I n d e x   v a c u u m��  ��  ��   A  L M L l     ��������  ��  ��   M  N O N l  A P P���� P r   A P Q R Q I  A L�� S��
�� .sysoexecTEXT���     TEXT S b   A H T U T b   A D V W V m   A B X X � Y Y 0 l s   - l n a h   ~ / L i b r a r y / M a i l / W o   B C���� 0 mail_version   U m   D G Z Z � [ [ p / M a i l D a t a   |   g r e p   - E   ' E n v e l o p e   I n d e x $ '   |   a w k   { ' p r i n t   $ 5 ' }��   R o      ���� 0 	sizeafter 	sizeAfter��  ��   O  \ ] \ l     ��������  ��  ��   ]  ^ _ ^ l  Q r `���� ` I  Q r�� a��
�� .sysodlogaskr        TEXT a l  Q n b���� b b   Q n c d c b   Q j e f e b   Q f g h g b   Q b i j i b   Q ^ k l k b   Q Z m n m b   Q V o p o m   Q T q q � r r & M a i l   i n d e x   b e f o r e :   p o   T U���� 0 
sizebefore 
sizeBefore n o   V Y��
�� 
ret  l m   Z ] s s � t t $ M a i l   i n d e x   a f t e r :   j o   ^ a���� 0 	sizeafter 	sizeAfter h o   b e��
�� 
ret  f o   f i��
�� 
ret  d m   j m u u � v v ( E n j o y   t h e   n e w   s p e e d !��  ��  ��  ��  ��   _  w x w l     ��������  ��  ��   x  y�� y l  s } z���� z O  s } { | { I  w |������
�� .miscactvnull��� ��� null��  ��   | m   s t } }�                                                                                  emal  alis    N  rosartl1-ml2-hd            �9��H+  ���Mail.app                                                       �ă���        ����  	                Applications    �9�      ���    ���  &rosartl1-ml2-hd:Applications: Mail.app    M a i l . a p p     r o s a r t l 1 - m l 2 - h d  Applications/Mail.app   / ��  ��  ��  ��       �� ~ ��   ~ ��
�� .aevtoappnull  �   � ****  �� ����� � ���
�� .aevtoappnull  �   � **** � k     } � �   � �   � �   � �  ! � �  2 � �  @ � �  N � �  ^ � �  y����  ��  ��   �   �  �� ���� �� % * . < >�� H J X Z�� q�� s u����
�� .aevtquitnull��� ��� null
�� .sysoexecTEXT���     TEXT�� 0 
os_version  �� 0 mail_version  �� 0 
sizebefore 
sizeBefore�� 0 	sizeafter 	sizeAfter
�� 
ret 
�� .sysodlogaskr        TEXT
�� .miscactvnull��� ��� null�� ~� *j UO�j E�O�E�O�g �� �E�Y hVO��%�%j E�O��%�%j O��%a %j E` Oa �%_ %a %_ %_ %_ %a %j O� *j U ascr  ��ޭ