From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 May 2018 11:03:56 +0100
Subject: [PATCH 0/4] migrate swapper_pg_dir
In-Reply-To: <20180529043728.27738-1-yaojun8558363@gmail.com>
References: <20180529043728.27738-1-yaojun8558363@gmail.com>
Message-ID: <20180529100356.uimq6p6ihpx4eeur@lakrids.cambridge.arm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Tue, May 29, 2018 at 12:37:28PM +0800, YaoJun wrote:
> Because the offset between swapper_pg_dir and _text is fixed, when
> attackers break KASLR, they can calculate the address of swapper_pg_dir,
> and then they can apply KSMA(Kernel Space Mirror Attack). The principle
> of KSMA is to insert an entry to PGD, and this entry has type of block
> with AP = 01, so attackers can read/write kernel memory directly. Details
> can reference:
> 
> https://www.blackhat.com/docs/asia-18/asia-18-WANG-KSMA-Breaking-Android-kernel-isolation-and-Rooting-with-ARM-MMU-features.pdf
> 
> These patches migrate swapper_pg_dir to new place, and there is no
> relationship between swapper_pg_dir and _text. Because this is done
> during kernel booting, the physical address of new swapper_pg_dir may
> be fixed. Do we need to further randomize it?

This looks interesting, but this didn't go to all the relevant people.

Could you please resend this series, with at least the following Cc'd:

* linux-arm-kernel at lists.infradead.org
* will.deacon at arm.com
* catalin.marinas at arm.com

Thanks,
Mark.

> 
> YaoJun (4):
>   Introduce a variable to record physical address of swapper_pg_dir.
>   Introduce a variable to record new virtual address of swapper_pg_dir.
>   Make tramp_pg_dir and swapper_pg_dir adjacent
>   Migrate swapper_pg_dir and tramp_pg_dir.
> 
>  arch/arm64/include/asm/mmu_context.h |  6 +--
>  arch/arm64/include/asm/pgtable.h     |  2 +
>  arch/arm64/kernel/cpufeature.c       |  2 +-
>  arch/arm64/kernel/entry.S            |  4 +-
>  arch/arm64/kernel/head.S             | 10 ++--
>  arch/arm64/kernel/hibernate.c        |  2 +-
>  arch/arm64/kernel/sleep.S            |  2 +
>  arch/arm64/kernel/vmlinux.lds.S      | 10 ++--
>  arch/arm64/mm/kasan_init.c           |  6 +--
>  arch/arm64/mm/mmu.c                  | 72 +++++++++++++++++++---------
>  10 files changed, 74 insertions(+), 42 deletions(-)
> 
> -- 
> 2.17.0
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
