def printVariables():
    for i in range(0, 24):
        print "var hour%d: String" % (i)
        print "var hour%dtemp: String" % (i)
        print "var hour%drain: String" % (i)
        print "var hour%dtext: String" % (i)
        print "var hour%dimg: UIImage" % (i)

print printVariables()
