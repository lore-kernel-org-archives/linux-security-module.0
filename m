From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 13:03:29 +0800
Subject: [PATCH 08/12] ima: added parser for RPM data type
In-Reply-To: <20170725154423.24845-9-roberto.sassu@huawei.com>
Message-ID: <201707271234.frmWtQgI%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Roberto,

[auto build test WARNING on integrity/next]
[also build test WARNING on v4.13-rc2 next-20170726]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/ima-measure-digest-lists-instead-of-individual-files/20170727-123131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   security/integrity/ima/ima_digest_list.c: In function 'ima_parse_rpm':
>> security/integrity/ima/ima_digest_list.c:147:4: warning: ignoring return value of 'hex2bin', declared with attribute warn_unused_result [-Wunused-result]
       hex2bin(digest, datap, digest_len);
       ^

vim +/hex2bin +147 security/integrity/ima/ima_digest_list.c

    98	
    99	static int ima_parse_rpm(loff_t size, void *buf)
   100	{
   101		void *bufp = buf, *bufendp = buf + size;
   102		struct rpm_hdr *hdr = bufp;
   103		u32 tags = be32_to_cpu(hdr->tags);
   104		struct rpm_entryinfo *entry;
   105		void *datap = bufp + sizeof(*hdr) + tags * sizeof(struct rpm_entryinfo);
   106		int digest_len = hash_digest_size[ima_hash_algo];
   107		u8 digest[digest_len];
   108		int ret, i, j;
   109	
   110		const unsigned char rpm_header_magic[8] = {
   111			0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
   112		};
   113	
   114		if (size < sizeof(*hdr)) {
   115			pr_err("Missing RPM header\n");
   116			return -EINVAL;
   117		}
   118	
   119		if (memcmp(bufp, rpm_header_magic, sizeof(rpm_header_magic))) {
   120			pr_err("Invalid RPM header\n");
   121			return -EINVAL;
   122		}
   123	
   124		bufp += sizeof(*hdr);
   125	
   126		for (i = 0; i < tags && (bufp + sizeof(*entry)) <= bufendp;
   127		     i++, bufp += sizeof(*entry)) {
   128			entry = bufp;
   129	
   130			if (be32_to_cpu(entry->tag) != RPMTAG_FILEDIGESTS)
   131				continue;
   132	
   133			datap += be32_to_cpu(entry->offset);
   134	
   135			for (j = 0; j < be32_to_cpu(entry->count) &&
   136			     datap < bufendp; j++) {
   137				if (strlen(datap) == 0) {
   138					datap++;
   139					continue;
   140				}
   141	
   142				if (datap + digest_len * 2 + 1 > bufendp) {
   143					pr_err("RPM header read at invalid offset\n");
   144					return -EINVAL;
   145				}
   146	
 > 147				hex2bin(digest, datap, digest_len);
   148	
   149				ret = ima_add_digest_data_entry(digest);
   150				if (ret < 0 && ret != -EEXIST)
   151					return ret;
   152	
   153				datap += digest_len * 2 + 1;
   154			}
   155	
   156			break;
   157		}
   158	
   159		return 0;
   160	}
   161	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
