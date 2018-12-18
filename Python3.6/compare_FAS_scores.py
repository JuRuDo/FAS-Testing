import xml.etree.ElementTree as ElTre
import sys

def readF(path):
    xmltree = ElTre.parse(path)
    root = xmltree.getroot()
    scoredict = {}
    for query in root:
        queryID = query.attrib["id"]
        scoredict[queryID] = {}
        for seed in query:
            seedID, score, ms, ps, cs, ls, mode = (seed.attrib["id"], seed.attrib["score"], seed.attrib["MS"], 
                                                  seed.attrib["PS"], seed.attrib["CS"], seed.attrib["LS"], 
                                                  seed.attrib["mode"])
            scoredict[queryID][seedID] = (score, ms, ps, cs, ls, mode)
    return scoredict

def compare(template, new, out):
    diff = 0
    miss = 0
    difflist = []
    for query in template:
        for seed in template[query]:
            try:
                for i in range(6):
                    if not template[query][seed][i] == new[query][seed][i]:
                        diff += 1
                        difflist.append((seed, query))
            except:
                miss += 1
    print("missing scores: " + str(miss) + "\nscore differences: " + str(diff))
    if diff > 0:
        print("writing score differences to " + out)
        outfile = open(out, 'w')
        outfile.write("#seed\tquery\n")
        for pair in difflist:
            outfile.write(pair[0] + "\t" + pair[1] + "\n")
        outfile.close()
        
def main(args):
    template = readF(args[0])
    new = readF(args[1])
    compare(template, new, args[2])

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
