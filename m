From: lkp@intel.com (kbuild test robot)
Date: Fri, 15 Jun 2018 21:03:06 +0800
Subject: [integrity:next-integrity-queued 22/22]
	security/integrity//evm/evm_crypto.c:99:8: warning: assignment to
	'struct
	crypto_shash *' from 'int' makes pointer from integer without a cast
Message-ID: <201806152136.T6tcKtVN%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
head:   26cfe10d4228820b110b2cd223c77a51fcf2cf41
commit: 26cfe10d4228820b110b2cd223c77a51fcf2cf41 [22/22] evm: Allow non-SHA1 digital signatures
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 26cfe10d4228820b110b2cd223c77a51fcf2cf41
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   security/integrity//evm/evm_crypto.c: In function 'init_desc':
   security/integrity//evm/evm_crypto.c:99:10: error: implicit declaration of function 'crypto_alloc_shash'; did you mean 'crypto_alloc_base'? [-Werror=implicit-function-declaration]
      *tfm = crypto_alloc_shash(algo, 0,
             ^~~~~~~~~~~~~~~~~~
             crypto_alloc_base
>> security/integrity//evm/evm_crypto.c:99:8: warning: assignment to 'struct crypto_shash *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      *tfm = crypto_alloc_shash(algo, 0,
           ^
   security/integrity//evm/evm_crypto.c:109:9: error: implicit declaration of function 'crypto_shash_setkey'; did you mean 'crypto_cipher_setkey'? [-Werror=implicit-function-declaration]
       rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
            ^~~~~~~~~~~~~~~~~~~
            crypto_cipher_setkey
   security/integrity//evm/evm_crypto.c:111:5: error: implicit declaration of function 'crypto_free_shash'; did you mean 'crypto_free_comp'? [-Werror=implicit-function-declaration]
        crypto_free_shash(*tfm);
        ^~~~~~~~~~~~~~~~~
        crypto_free_comp
   security/integrity//evm/evm_crypto.c:121:24: error: dereferencing pointer to incomplete type 'struct shash_desc'
     desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                           ^~~~~
   security/integrity//evm/evm_crypto.c:121:33: error: implicit declaration of function 'crypto_shash_descsize'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                                    ^~~~~~~~~~~~~~~~~~~~~
                                    crypto_sha1_update
   security/integrity//evm/evm_crypto.c:129:7: error: implicit declaration of function 'crypto_shash_init'; did you mean 'crypto_sha1_finup'? [-Werror=implicit-function-declaration]
     rc = crypto_shash_init(desc);
          ^~~~~~~~~~~~~~~~~
          crypto_sha1_finup
   security/integrity//evm/evm_crypto.c: In function 'hmac_add_misc':
   security/integrity//evm/evm_crypto.c:173:2: error: implicit declaration of function 'crypto_shash_update'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
     ^~~~~~~~~~~~~~~~~~~
     crypto_sha1_update
   security/integrity//evm/evm_crypto.c:178:2: error: implicit declaration of function 'crypto_shash_final'; did you mean 'crypto_sha1_finup'? [-Werror=implicit-function-declaration]
     crypto_shash_final(desc, digest);
     ^~~~~~~~~~~~~~~~~~
     crypto_sha1_finup
   security/integrity//evm/evm_crypto.c: In function 'evm_calc_hmac_or_hash':
   security/integrity//evm/evm_crypto.c:210:21: error: implicit declaration of function 'crypto_shash_digestsize'; did you mean 'crypto_sha1_update'? [-Werror=implicit-function-declaration]
     data->hdr.length = crypto_shash_digestsize(desc->tfm);
                        ^~~~~~~~~~~~~~~~~~~~~~~
                        crypto_sha1_update
   cc1: some warnings being treated as errors

vim +99 security/integrity//evm/evm_crypto.c

762667632 Dmitry Kasatkin 2015-10-22   75  
26cfe10d4 Matthew Garrett 2018-06-08   76  static struct shash_desc *init_desc(char type, uint8_t hash_algo)
66dbc325a Mimi Zohar      2011-03-15   77  {
143b01d33 Dmitry Kasatkin 2011-12-05   78  	long rc;
26cfe10d4 Matthew Garrett 2018-06-08   79  	const char *algo;
15647eb39 Dmitry Kasatkin 2011-09-01   80  	struct crypto_shash **tfm;
d46eb3699 Dmitry Kasatkin 2011-03-09   81  	struct shash_desc *desc;
d46eb3699 Dmitry Kasatkin 2011-03-09   82  
15647eb39 Dmitry Kasatkin 2011-09-01   83  	if (type == EVM_XATTR_HMAC) {
26ddabfe9 Dmitry Kasatkin 2015-10-22   84  		if (!(evm_initialized & EVM_INIT_HMAC)) {
0485d066d Matthew Garrett 2017-10-11   85  			pr_err_once("HMAC key is not set\n");
26ddabfe9 Dmitry Kasatkin 2015-10-22   86  			return ERR_PTR(-ENOKEY);
26ddabfe9 Dmitry Kasatkin 2015-10-22   87  		}
15647eb39 Dmitry Kasatkin 2011-09-01   88  		tfm = &hmac_tfm;
15647eb39 Dmitry Kasatkin 2011-09-01   89  		algo = evm_hmac;
15647eb39 Dmitry Kasatkin 2011-09-01   90  	} else {
26cfe10d4 Matthew Garrett 2018-06-08   91  		tfm = &evm_tfm[hash_algo];
26cfe10d4 Matthew Garrett 2018-06-08   92  		algo = hash_algo_name[hash_algo];
15647eb39 Dmitry Kasatkin 2011-09-01   93  	}
15647eb39 Dmitry Kasatkin 2011-09-01   94  
15647eb39 Dmitry Kasatkin 2011-09-01   95  	if (*tfm == NULL) {
97426f985 Dmitry Kasatkin 2011-12-05   96  		mutex_lock(&mutex);
143b01d33 Dmitry Kasatkin 2011-12-05   97  		if (*tfm)
97426f985 Dmitry Kasatkin 2011-12-05   98  			goto out;
fdc33c29b Matthew Garrett 2018-06-08  @99  		*tfm = crypto_alloc_shash(algo, 0,
fdc33c29b Matthew Garrett 2018-06-08  100  					  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
15647eb39 Dmitry Kasatkin 2011-09-01  101  		if (IS_ERR(*tfm)) {
15647eb39 Dmitry Kasatkin 2011-09-01  102  			rc = PTR_ERR(*tfm);
143b01d33 Dmitry Kasatkin 2011-12-05  103  			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
15647eb39 Dmitry Kasatkin 2011-09-01  104  			*tfm = NULL;
97426f985 Dmitry Kasatkin 2011-12-05  105  			mutex_unlock(&mutex);
d46eb3699 Dmitry Kasatkin 2011-03-09  106  			return ERR_PTR(rc);
d46eb3699 Dmitry Kasatkin 2011-03-09  107  		}
88d7ed350 Dmitry Kasatkin 2011-12-05  108  		if (type == EVM_XATTR_HMAC) {
88d7ed350 Dmitry Kasatkin 2011-12-05  109  			rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
d21b59451 Dmitry Kasatkin 2011-12-05  110  			if (rc) {
88d7ed350 Dmitry Kasatkin 2011-12-05  111  				crypto_free_shash(*tfm);
88d7ed350 Dmitry Kasatkin 2011-12-05  112  				*tfm = NULL;
97426f985 Dmitry Kasatkin 2011-12-05  113  				mutex_unlock(&mutex);
d21b59451 Dmitry Kasatkin 2011-12-05  114  				return ERR_PTR(rc);
d21b59451 Dmitry Kasatkin 2011-12-05  115  			}
88d7ed350 Dmitry Kasatkin 2011-12-05  116  		}
97426f985 Dmitry Kasatkin 2011-12-05  117  out:
97426f985 Dmitry Kasatkin 2011-12-05  118  		mutex_unlock(&mutex);
66dbc325a Mimi Zohar      2011-03-15  119  	}
d46eb3699 Dmitry Kasatkin 2011-03-09  120  
15647eb39 Dmitry Kasatkin 2011-09-01  121  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
d46eb3699 Dmitry Kasatkin 2011-03-09  122  			GFP_KERNEL);
d46eb3699 Dmitry Kasatkin 2011-03-09  123  	if (!desc)
d46eb3699 Dmitry Kasatkin 2011-03-09  124  		return ERR_PTR(-ENOMEM);
d46eb3699 Dmitry Kasatkin 2011-03-09  125  
15647eb39 Dmitry Kasatkin 2011-09-01  126  	desc->tfm = *tfm;
d46eb3699 Dmitry Kasatkin 2011-03-09  127  	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
d46eb3699 Dmitry Kasatkin 2011-03-09  128  
d46eb3699 Dmitry Kasatkin 2011-03-09  129  	rc = crypto_shash_init(desc);
d46eb3699 Dmitry Kasatkin 2011-03-09  130  	if (rc) {
d46eb3699 Dmitry Kasatkin 2011-03-09  131  		kfree(desc);
d46eb3699 Dmitry Kasatkin 2011-03-09  132  		return ERR_PTR(rc);
d46eb3699 Dmitry Kasatkin 2011-03-09  133  	}
d46eb3699 Dmitry Kasatkin 2011-03-09  134  	return desc;
66dbc325a Mimi Zohar      2011-03-15  135  }
66dbc325a Mimi Zohar      2011-03-15  136  

:::::: The code at line 99 was first introduced by commit
:::::: fdc33c29b022dd4ee9ba8af722b5ba8fec40549f evm: Don't deadlock if a crypto algorithm is unavailable

:::::: TO: Matthew Garrett <mjg59@google.com>
:::::: CC: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
