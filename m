From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 22 Sep 2018 00:57:01 +0300
Subject: [PATCH v2, RESEND 2/3] tpm: modify tpm_pcr_read() definition to
	pass TPM hash algorithms
In-Reply-To: <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
	<20180917093820.20500-3-roberto.sassu@huawei.com>
	<411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
Message-ID: <20180921215701.GA23799@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 12:24:15PM +0200, Roberto Sassu wrote:
> On 9/17/2018 11:38 AM, Roberto Sassu wrote:
> > Currently the TPM driver allows other kernel subsystems to read only the
> > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > tpm2_pcr_read() to pass an array of tpm_digest structures, which contains
> > the desired hash algorithms. Initially, the array size is limited to 1.
> 
> Jarkko, is this patch ok?
> 
> Mimi, I wait for your review of the IMA part.
> 
> Roberto

Oops, just bumped into these. Have to check next week. Please add me to
either to- or cc-field in the future.

/Jarkko
