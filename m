From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sun, 16 Sep 2018 22:26:56 +0300
Subject: [PATCH v6 0/2] tpm: add support for nonblocking operation
In-Reply-To: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
	<20180916120349.GB5040@linux.intel.com>
	<f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
Message-ID: <20180916192656.GA9053@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 16, 2018 at 08:11:44AM -0700, Tadeusz Struk wrote:
> On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> > I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async
> 
> This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
> To enable it you need to configure tss with --enable-tcti-device-async=yes
> Thanks,
> Tadeusz

Thank you. Looking forward to try it out tomorrow.

/Jarkko
