From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 18 Sep 2018 09:14:43 +0200
Subject: [PATCH v2 3/3] tpm: retrieve digest size of unknown algorithms
	with PCR read
In-Reply-To: <20180917211622.GC6716@linux.intel.com>
References: <20180905114202.7757-1-roberto.sassu@huawei.com>
	<20180905114202.7757-4-roberto.sassu@huawei.com>
	<20180916123749.GF5040@linux.intel.com>
	<322eb81b-3f3e-e37e-5fb0-a37aad3d06d7@huawei.com>
	<20180917211622.GC6716@linux.intel.com>
Message-ID: <8621eb6d-b252-4fb3-cb67-294f0aafb54c@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/17/2018 11:16 PM, Jarkko Sakkinen wrote:
> On Mon, Sep 17, 2018 at 12:02:56PM +0200, Roberto Sassu wrote:
>> This code has the same behavior of tpm2_get_pcr_allocation(). If some
>> banks are not used, set the algorithm of the first unused to
>> TPM_ALG_ERROR.
> 
> My point is that maybe it would sense to use zero for that in order
> to make code a bit simpler.

Wouldn't be better to compare data with the same type? Since the alg_id
structure member stores an algorithm, it should be fine to compare its
value with an algorithm.

No problem to change that, but probably I should modify also
tpm_pcr_extend().

Roberto
