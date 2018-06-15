From: lkp@intel.com (kbuild test robot)
Date: Fri, 15 Jun 2018 19:18:07 +0800
Subject: [integrity:next-integrity-queued 22/22]
	security/integrity/evm/evm_crypto.c:99:10: error: implicit declaration
	of function 'crypto_alloc_shash'; did you mean 'crypto_alloc_base'?
Message-ID: <201806151905.gEmu1Z62%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
head:   26cfe10d4228820b110b2cd223c77a51fcf2cf41
commit: 26cfe10d4228820b110b2cd223c77a51fcf2cf41 [22/22] evm: Allow non-SHA1 digital signatures
config: x86_64-randconfig-x012-201823 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 26cfe10d4228820b110b2cd223c77a51fcf2cf41
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   security/integrity/evm/evm_crypto.c: In function 'init_desc':
>> security/integrity/evm/evm_crypto.c:99:10: error: implicit declaration of function 'crypto_alloc_shash'; did you mean 'crypto_alloc_base'? [-Werror=implicit-function-declaration]
      *tfm = crypto_alloc_shash(algo, 0,
             ^~~~~~~~~~~~~~~~~~
             crypto_alloc_base
>> security/integrity/evm/evm_crypto.c:99:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      *tfm = crypto_alloc_shash(algo, 0,
           ^
>> security/integrity/evm/evm_crypto.c:109:9: error: implicit declaration of function 'crypto_shash_setkey'; did you mean 'crypto_cipher_setkey'? [-Werror=implicit-function-declaration]
       rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
            ^~~~~~~~~~~~~~~~~~~
            crypto_cipher_setkey
>> security/integrity/evm/evm_crypto.c:111:5: error: implicit declaration of function 'crypto_free_shash'; did you mean 'crypto_free_comp'? [-Werror=implicit-function-declaration]
        crypto_free_shash(*tfm);
        ^~~~~~~~~~~~~~~~~
        crypto_free_comp
>> security/integrity/evm/evm_crypto.c:121:24: error: dereferencing pointer to incomplete type 'struct shash_desc'
     desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                           ^~~~~
>> security/integrity/evm/evm_crypto.c:121:33: error: implicit declaration of function 'crypto_shash_descsize'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                                    ^~~~~~~~~~~~~~~~~~~~~
                                    crypto_sha1_update
>> security/integrity/evm/evm_crypto.c:129:7: error: implicit declaration of function 'crypto_shash_init'; did you mean 'crypto_sha1_finup'? [-Werror=implicit-function-declaration]
     rc = crypto_shash_init(desc);
          ^~~~~~~~~~~~~~~~~
          crypto_sha1_finup
   security/integrity/evm/evm_crypto.c: In function 'hmac_add_misc':
>> security/integrity/evm/evm_crypto.c:173:2: error: implicit declaration of function 'crypto_shash_update'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
     ^~~~~~~~~~~~~~~~~~~
     crypto_sha1_update
>> security/integrity/evm/evm_crypto.c:178:2: error: implicit declaration of function 'crypto_shash_final'; did you mean 'crypto_sha1_finup'? [-Werror=implicit-function-declaration]
     crypto_shash_final(desc, digest);
     ^~~~~~~~~~~~~~~~~~
     crypto_sha1_finup
   security/integrity/evm/evm_crypto.c: In function 'evm_calc_hmac_or_hash':
>> security/integrity/evm/evm_crypto.c:210:21: error: implicit declaration of function 'crypto_shash_digestsize'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     data->hdr.length = crypto_shash_digestsize(desc->tfm);
                        ^~~~~~~~~~~~~~~~~~~~~~~
                        crypto_sha1_update
   cc1: some warnings being treated as errors

vim +99 security/integrity/evm/evm_crypto.c

762667632 Dmitry Kasatkin     2015-10-22   75  
26cfe10d4 Matthew Garrett     2018-06-08   76  static struct shash_desc *init_desc(char type, uint8_t hash_algo)
66dbc325a Mimi Zohar          2011-03-15   77  {
143b01d33 Dmitry Kasatkin     2011-12-05   78  	long rc;
26cfe10d4 Matthew Garrett     2018-06-08   79  	const char *algo;
15647eb39 Dmitry Kasatkin     2011-09-01   80  	struct crypto_shash **tfm;
d46eb3699 Dmitry Kasatkin     2011-03-09   81  	struct shash_desc *desc;
d46eb3699 Dmitry Kasatkin     2011-03-09   82  
15647eb39 Dmitry Kasatkin     2011-09-01   83  	if (type == EVM_XATTR_HMAC) {
26ddabfe9 Dmitry Kasatkin     2015-10-22   84  		if (!(evm_initialized & EVM_INIT_HMAC)) {
0485d066d Matthew Garrett     2017-10-11   85  			pr_err_once("HMAC key is not set\n");
26ddabfe9 Dmitry Kasatkin     2015-10-22   86  			return ERR_PTR(-ENOKEY);
26ddabfe9 Dmitry Kasatkin     2015-10-22   87  		}
15647eb39 Dmitry Kasatkin     2011-09-01   88  		tfm = &hmac_tfm;
15647eb39 Dmitry Kasatkin     2011-09-01   89  		algo = evm_hmac;
15647eb39 Dmitry Kasatkin     2011-09-01   90  	} else {
26cfe10d4 Matthew Garrett     2018-06-08   91  		tfm = &evm_tfm[hash_algo];
26cfe10d4 Matthew Garrett     2018-06-08   92  		algo = hash_algo_name[hash_algo];
15647eb39 Dmitry Kasatkin     2011-09-01   93  	}
15647eb39 Dmitry Kasatkin     2011-09-01   94  
15647eb39 Dmitry Kasatkin     2011-09-01   95  	if (*tfm == NULL) {
97426f985 Dmitry Kasatkin     2011-12-05   96  		mutex_lock(&mutex);
143b01d33 Dmitry Kasatkin     2011-12-05   97  		if (*tfm)
97426f985 Dmitry Kasatkin     2011-12-05   98  			goto out;
fdc33c29b Matthew Garrett     2018-06-08  @99  		*tfm = crypto_alloc_shash(algo, 0,
fdc33c29b Matthew Garrett     2018-06-08  100  					  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
15647eb39 Dmitry Kasatkin     2011-09-01  101  		if (IS_ERR(*tfm)) {
15647eb39 Dmitry Kasatkin     2011-09-01  102  			rc = PTR_ERR(*tfm);
143b01d33 Dmitry Kasatkin     2011-12-05  103  			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
15647eb39 Dmitry Kasatkin     2011-09-01  104  			*tfm = NULL;
97426f985 Dmitry Kasatkin     2011-12-05  105  			mutex_unlock(&mutex);
d46eb3699 Dmitry Kasatkin     2011-03-09  106  			return ERR_PTR(rc);
d46eb3699 Dmitry Kasatkin     2011-03-09  107  		}
88d7ed350 Dmitry Kasatkin     2011-12-05  108  		if (type == EVM_XATTR_HMAC) {
88d7ed350 Dmitry Kasatkin     2011-12-05 @109  			rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
d21b59451 Dmitry Kasatkin     2011-12-05  110  			if (rc) {
88d7ed350 Dmitry Kasatkin     2011-12-05 @111  				crypto_free_shash(*tfm);
88d7ed350 Dmitry Kasatkin     2011-12-05  112  				*tfm = NULL;
97426f985 Dmitry Kasatkin     2011-12-05  113  				mutex_unlock(&mutex);
d21b59451 Dmitry Kasatkin     2011-12-05  114  				return ERR_PTR(rc);
d21b59451 Dmitry Kasatkin     2011-12-05  115  			}
88d7ed350 Dmitry Kasatkin     2011-12-05  116  		}
97426f985 Dmitry Kasatkin     2011-12-05  117  out:
97426f985 Dmitry Kasatkin     2011-12-05  118  		mutex_unlock(&mutex);
66dbc325a Mimi Zohar          2011-03-15  119  	}
d46eb3699 Dmitry Kasatkin     2011-03-09  120  
15647eb39 Dmitry Kasatkin     2011-09-01 @121  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
d46eb3699 Dmitry Kasatkin     2011-03-09  122  			GFP_KERNEL);
d46eb3699 Dmitry Kasatkin     2011-03-09  123  	if (!desc)
d46eb3699 Dmitry Kasatkin     2011-03-09  124  		return ERR_PTR(-ENOMEM);
d46eb3699 Dmitry Kasatkin     2011-03-09  125  
15647eb39 Dmitry Kasatkin     2011-09-01  126  	desc->tfm = *tfm;
d46eb3699 Dmitry Kasatkin     2011-03-09  127  	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
d46eb3699 Dmitry Kasatkin     2011-03-09  128  
d46eb3699 Dmitry Kasatkin     2011-03-09 @129  	rc = crypto_shash_init(desc);
d46eb3699 Dmitry Kasatkin     2011-03-09  130  	if (rc) {
d46eb3699 Dmitry Kasatkin     2011-03-09  131  		kfree(desc);
d46eb3699 Dmitry Kasatkin     2011-03-09  132  		return ERR_PTR(rc);
d46eb3699 Dmitry Kasatkin     2011-03-09  133  	}
d46eb3699 Dmitry Kasatkin     2011-03-09  134  	return desc;
66dbc325a Mimi Zohar          2011-03-15  135  }
66dbc325a Mimi Zohar          2011-03-15  136  
66dbc325a Mimi Zohar          2011-03-15  137  /* Protect against 'cutting & pasting' security.evm xattr, include inode
66dbc325a Mimi Zohar          2011-03-15  138   * specific info.
66dbc325a Mimi Zohar          2011-03-15  139   *
66dbc325a Mimi Zohar          2011-03-15  140   * (Additional directory/file metadata needs to be added for more complete
66dbc325a Mimi Zohar          2011-03-15  141   * protection.)
66dbc325a Mimi Zohar          2011-03-15  142   */
d46eb3699 Dmitry Kasatkin     2011-03-09  143  static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
50b977481 Matthew Garrett     2017-11-07  144  			  char type, char *digest)
66dbc325a Mimi Zohar          2011-03-15  145  {
66dbc325a Mimi Zohar          2011-03-15  146  	struct h_misc {
66dbc325a Mimi Zohar          2011-03-15  147  		unsigned long ino;
66dbc325a Mimi Zohar          2011-03-15  148  		__u32 generation;
66dbc325a Mimi Zohar          2011-03-15  149  		uid_t uid;
66dbc325a Mimi Zohar          2011-03-15  150  		gid_t gid;
66dbc325a Mimi Zohar          2011-03-15  151  		umode_t mode;
66dbc325a Mimi Zohar          2011-03-15  152  	} hmac_misc;
66dbc325a Mimi Zohar          2011-03-15  153  
2bb930abc Dmitry Kasatkin     2014-03-04  154  	memset(&hmac_misc, 0, sizeof(hmac_misc));
50b977481 Matthew Garrett     2017-11-07  155  	/* Don't include the inode or generation number in portable
50b977481 Matthew Garrett     2017-11-07  156  	 * signatures
50b977481 Matthew Garrett     2017-11-07  157  	 */
50b977481 Matthew Garrett     2017-11-07  158  	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
66dbc325a Mimi Zohar          2011-03-15  159  		hmac_misc.ino = inode->i_ino;
66dbc325a Mimi Zohar          2011-03-15  160  		hmac_misc.generation = inode->i_generation;
50b977481 Matthew Garrett     2017-11-07  161  	}
19339c251 Eric W. Biederman   2016-12-02  162  	/* The hmac uid and gid must be encoded in the initial user
19339c251 Eric W. Biederman   2016-12-02  163  	 * namespace (not the filesystems user namespace) as encoding
19339c251 Eric W. Biederman   2016-12-02  164  	 * them in the filesystems user namespace allows an attack
19339c251 Eric W. Biederman   2016-12-02  165  	 * where first they are written in an unprivileged fuse mount
19339c251 Eric W. Biederman   2016-12-02  166  	 * of a filesystem and then the system is tricked to mount the
19339c251 Eric W. Biederman   2016-12-02  167  	 * filesystem for real on next boot and trust it because
19339c251 Eric W. Biederman   2016-12-02  168  	 * everything is signed.
19339c251 Eric W. Biederman   2016-12-02  169  	 */
19339c251 Eric W. Biederman   2016-12-02  170  	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
19339c251 Eric W. Biederman   2016-12-02  171  	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
66dbc325a Mimi Zohar          2011-03-15  172  	hmac_misc.mode = inode->i_mode;
2bb930abc Dmitry Kasatkin     2014-03-04 @173  	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
50b977481 Matthew Garrett     2017-11-07  174  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
50b977481 Matthew Garrett     2017-11-07  175  	    type != EVM_XATTR_PORTABLE_DIGSIG)
85787090a Christoph Hellwig   2017-05-10  176  		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
74de66842 Dmitry Kasatkin     2012-09-10  177  				    sizeof(inode->i_sb->s_uuid));
d46eb3699 Dmitry Kasatkin     2011-03-09 @178  	crypto_shash_final(desc, digest);
66dbc325a Mimi Zohar          2011-03-15  179  }
66dbc325a Mimi Zohar          2011-03-15  180  
66dbc325a Mimi Zohar          2011-03-15  181  /*
66dbc325a Mimi Zohar          2011-03-15  182   * Calculate the HMAC value across the set of protected security xattrs.
66dbc325a Mimi Zohar          2011-03-15  183   *
66dbc325a Mimi Zohar          2011-03-15  184   * Instead of retrieving the requested xattr, for performance, calculate
66dbc325a Mimi Zohar          2011-03-15  185   * the hmac using the requested xattr value. Don't alloc/free memory for
66dbc325a Mimi Zohar          2011-03-15  186   * each xattr, but attempt to re-use the previously allocated memory.
66dbc325a Mimi Zohar          2011-03-15  187   */
15647eb39 Dmitry Kasatkin     2011-09-01  188  static int evm_calc_hmac_or_hash(struct dentry *dentry,
15647eb39 Dmitry Kasatkin     2011-09-01  189  				 const char *req_xattr_name,
15647eb39 Dmitry Kasatkin     2011-09-01  190  				 const char *req_xattr_value,
15647eb39 Dmitry Kasatkin     2011-09-01  191  				 size_t req_xattr_value_len,
26cfe10d4 Matthew Garrett     2018-06-08  192  				 uint8_t type, struct evm_digest *data)
66dbc325a Mimi Zohar          2011-03-15  193  {
c6f493d63 David Howells       2015-03-17  194  	struct inode *inode = d_backing_inode(dentry);
21af76631 Matthew Garrett     2018-05-11  195  	struct xattr_list *xattr;
d46eb3699 Dmitry Kasatkin     2011-03-09  196  	struct shash_desc *desc;
66dbc325a Mimi Zohar          2011-03-15  197  	size_t xattr_size = 0;
66dbc325a Mimi Zohar          2011-03-15  198  	char *xattr_value = NULL;
66dbc325a Mimi Zohar          2011-03-15  199  	int error;
66dbc325a Mimi Zohar          2011-03-15  200  	int size;
50b977481 Matthew Garrett     2017-11-07  201  	bool ima_present = false;
66dbc325a Mimi Zohar          2011-03-15  202  
5d6c31910 Andreas Gruenbacher 2016-09-29  203  	if (!(inode->i_opflags & IOP_XATTR))
66dbc325a Mimi Zohar          2011-03-15  204  		return -EOPNOTSUPP;
5d6c31910 Andreas Gruenbacher 2016-09-29  205  
26cfe10d4 Matthew Garrett     2018-06-08  206  	desc = init_desc(type, data->hdr.algo);
d46eb3699 Dmitry Kasatkin     2011-03-09  207  	if (IS_ERR(desc))
d46eb3699 Dmitry Kasatkin     2011-03-09  208  		return PTR_ERR(desc);
66dbc325a Mimi Zohar          2011-03-15  209  
26cfe10d4 Matthew Garrett     2018-06-08 @210  	data->hdr.length = crypto_shash_digestsize(desc->tfm);
26cfe10d4 Matthew Garrett     2018-06-08  211  
66dbc325a Mimi Zohar          2011-03-15  212  	error = -ENODATA;
fa516b66a Matthew Garrett     2018-05-15  213  	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
50b977481 Matthew Garrett     2017-11-07  214  		bool is_ima = false;
50b977481 Matthew Garrett     2017-11-07  215  
21af76631 Matthew Garrett     2018-05-11  216  		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
50b977481 Matthew Garrett     2017-11-07  217  			is_ima = true;
50b977481 Matthew Garrett     2017-11-07  218  
66dbc325a Mimi Zohar          2011-03-15  219  		if ((req_xattr_name && req_xattr_value)
21af76631 Matthew Garrett     2018-05-11  220  		    && !strcmp(xattr->name, req_xattr_name)) {
66dbc325a Mimi Zohar          2011-03-15  221  			error = 0;
d46eb3699 Dmitry Kasatkin     2011-03-09  222  			crypto_shash_update(desc, (const u8 *)req_xattr_value,
d46eb3699 Dmitry Kasatkin     2011-03-09  223  					     req_xattr_value_len);
50b977481 Matthew Garrett     2017-11-07  224  			if (is_ima)
50b977481 Matthew Garrett     2017-11-07  225  				ima_present = true;
66dbc325a Mimi Zohar          2011-03-15  226  			continue;
66dbc325a Mimi Zohar          2011-03-15  227  		}
21af76631 Matthew Garrett     2018-05-11  228  		size = vfs_getxattr_alloc(dentry, xattr->name,
66dbc325a Mimi Zohar          2011-03-15  229  					  &xattr_value, xattr_size, GFP_NOFS);
66dbc325a Mimi Zohar          2011-03-15  230  		if (size == -ENOMEM) {
66dbc325a Mimi Zohar          2011-03-15  231  			error = -ENOMEM;
66dbc325a Mimi Zohar          2011-03-15  232  			goto out;
66dbc325a Mimi Zohar          2011-03-15  233  		}
66dbc325a Mimi Zohar          2011-03-15  234  		if (size < 0)
66dbc325a Mimi Zohar          2011-03-15  235  			continue;
66dbc325a Mimi Zohar          2011-03-15  236  
66dbc325a Mimi Zohar          2011-03-15  237  		error = 0;
66dbc325a Mimi Zohar          2011-03-15  238  		xattr_size = size;
d46eb3699 Dmitry Kasatkin     2011-03-09  239  		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
50b977481 Matthew Garrett     2017-11-07  240  		if (is_ima)
50b977481 Matthew Garrett     2017-11-07  241  			ima_present = true;
66dbc325a Mimi Zohar          2011-03-15  242  	}
26cfe10d4 Matthew Garrett     2018-06-08  243  	hmac_add_misc(desc, inode, type, data->digest);
d46eb3699 Dmitry Kasatkin     2011-03-09  244  
50b977481 Matthew Garrett     2017-11-07  245  	/* Portable EVM signatures must include an IMA hash */
50b977481 Matthew Garrett     2017-11-07  246  	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
50b977481 Matthew Garrett     2017-11-07  247  		return -EPERM;
66dbc325a Mimi Zohar          2011-03-15  248  out:
d46eb3699 Dmitry Kasatkin     2011-03-09  249  	kfree(xattr_value);
d46eb3699 Dmitry Kasatkin     2011-03-09  250  	kfree(desc);
66dbc325a Mimi Zohar          2011-03-15  251  	return error;
66dbc325a Mimi Zohar          2011-03-15  252  }
66dbc325a Mimi Zohar          2011-03-15  253  

:::::: The code at line 99 was first introduced by commit
:::::: fdc33c29b022dd4ee9ba8af722b5ba8fec40549f evm: Don't deadlock if a crypto algorithm is unavailable

:::::: TO: Matthew Garrett <mjg59@google.com>
:::::: CC: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
