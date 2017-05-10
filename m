From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 11 May 2017 01:41:15 +0200
Subject: [PATCH] tpm: fix byte order related arithmetic inconsistency in
	tpm_getcap()
In-Reply-To: <20170510123458.fh3ef3c55y2wiu35@intel.com>
References: <20170507175002.9558-1-jarkko.sakkinen@linux.intel.com>
	<20170509141353.klo7lilef4qiqfoc@intel.com>
	<20170509151308.GA13586@obsidianresearch.com>
	<20170510123458.fh3ef3c55y2wiu35@intel.com>
Message-ID: <CAExDi1RODELLA+N4_5JS3LcDa5DN4q_imYwhw4hd4BHq1GFRBw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 2:34 PM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:

> Arithmetic should work but it's not a good practice to do additions,
> substractions or multiplications in any other byte order than the CPU
> byte order.
>
> sparse also complains about this.
>
> /Jarkko

Arithmetic should work?
let's try with 0x0080:
in native order: 0x0080 + 0x0080 = 0x0100
in reverse order: 0x8000 + 0x8000 = 0x0000 != swap16(0x0100)

Or do I misunderstand what you mean by "arithmetic should work"?

-- Luc Van Oostenryck
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
