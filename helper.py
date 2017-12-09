def printVariables():
    for i in range(0, 24):
        print "var hour%d: String" % (i)
        print "var hour%dtemp: String" % (i)
        print "var hour%drain: String" % (i)
        print "var hour%dtext: String" % (i)
        print "var hour%dimg: UIImage" % (i)

def printParameters():
    for i in range (0, 24):
        print "hour%d: String, " % (i)
        print "hour%dtemp: String, " % (i)
        print "hour%drain: String, " % (i)
        print "hour%dtext: String, " % (i)
        print "hour%dimg: UIImage, " % (i)

def printInit():
    for i in range (0, 24):
        print "self.hour%d = hour%d" % (i, i)
        print "self.hour%dtemp = hour%dtemp" % (i, i)
        print "self.hour%drain = hour%drain" % (i, i)
        print "self.hour%dtext = hour%dtext" % (i, i)
        print "self.hour%dimg = hour%dimg" % (i, i)

##########
## main ##
##########

#print printVariables()
#print printParameters()
#print printInit()
