From: zohar@linux.ibm.com (Mimi Zohar)
Date: Fri, 21 Sep 2018 09:59:49 -0400
Subject: [PATCH v2, RESEND 2/3] tpm: modify tpm_pcr_read() definition to
	pass TPM hash algorithms
In-Reply-To: <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
	<20180917093820.20500-3-roberto.sassu@huawei.com>
	<411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
Message-ID: <1537538389.3830.336.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-21 at 12:24 +0200, Roberto Sassu wrote:
> On 9/17/2018 11:38 AM, Roberto Sassu wrote:
> > Currently the TPM driver allows other kernel subsystems to read only the
> > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > tpm2_pcr_read() to pass an array of tpm_digest structures, which contains
> > the desired hash algorithms. Initially, the array size is limited to 1.
> 
> Jarkko, is this patch ok?
> 
> Mimi, I wait for your review of the IMA part.

Yes, I know. ?I've been on vacation and am hoping to review your, Eric
Bigger's and Nayna's patches soon. ?Sorry for the delay!

Mimi
