From: tstruk@gmail.com (Tadeusz Struk)
Date: Sun, 16 Sep 2018 08:11:44 -0700
Subject: [PATCH v6 0/2] tpm: add support for nonblocking operation
In-Reply-To: <20180916120349.GB5040@linux.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
	<20180916120349.GB5040@linux.intel.com>
Message-ID: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async

This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
To enable it you need to configure tss with --enable-tcti-device-async=yes
Thanks,
Tadeusz
