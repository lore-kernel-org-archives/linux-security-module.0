From: xiaolong.ye@intel.com (Ye Xiaolong)
Date: Tue, 31 Jul 2018 10:00:36 +0800
Subject: [LKP] [lkp-robot] [confidence: ] 7757d607c6 [ 56.996267] BUG:
	Bad page map in process trinity-c2 pte:0d755065 pmd:0d55b067
In-Reply-To: <20180727132542.mt35m3knpwpsyb73@suse.de>
References: <20180721022325.GF12513@shao2-debian>
	<20180727132542.mt35m3knpwpsyb73@suse.de>
Message-ID: <20180731020036.GB22500@yexl-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On 07/27, Joerg Roedel wrote:
>Hey,
>
>thanks for the report! It did a lot of testing and the issue is fixed
>now with this patch:
>
>	https://lore.kernel.org/lkml/1532533683-5988-4-git-send-email-joro at 8bytes.org/
>
>I did 2150 runs of your reproducer with the reproducer attached to this
>report, and the issue triggered three times.
>
>With the patch above the issue did not trigger anymore in (up to now)
>2170 runs of the reproducer.
>
>On Sat, Jul 21, 2018 at 10:23:25AM +0800, kernel test robot wrote:
>> git bisect start 8c934e01a7ce685d98e970880f5941d79272c654 37b5dca2898d1471729194f45e281c2443eb9d6c --
>> git bisect good 8372d66865deb45ee3ec21401a9c80f231b728c8  # 23:36  G    304     0    4   4  x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
>> git bisect good b976690f5db26fbc7c2be413bfa0fbd270547a94  # 00:10  G    305     0    5   5  x86/mm/pti: Introduce pti_finalize()
>> git bisect good 9bae3197e15dd5e03ce8e237db6fe4486b08a775  # 00:49  G    308     0    3   4  x86/ldt: Split out sanity check in map_ldt_struct()
>> git bisect  bad 5e8105950a8b3e03e805299b4d05020ee4eda31a  # 01:12  B    131     1    4   4  x86/mm/pti: Add Warning when booting on a PCID capable CPU
>> git bisect good 6df934b92a549cb3badb6d576f71aeb133e2f110  # 01:47  G    310     0    7  10  x86/ldt: Enable LDT user-mapping for PAE
>> git bisect  bad 7757d607c6b31867777de42e1fb0210b9c5d8b70  # 02:08  B    134     1    2   2  x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
>> # first bad commit: [7757d607c6b31867777de42e1fb0210b9c5d8b70] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
>> git bisect good 6df934b92a549cb3badb6d576f71aeb133e2f110  # 03:14  G    900     0    9  19  x86/ldt: Enable LDT user-mapping for PAE
>> # extra tests on HEAD of tip/x86/pti
>> git bisect  bad 8c934e01a7ce685d98e970880f5941d79272c654  # 03:15  B    279     2    0   6  x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
>> # extra tests on tree/branch tip/x86/pti
>> git bisect  bad 8c934e01a7ce685d98e970880f5941d79272c654  # 03:20  B    279     2    0   6  x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
>> # extra tests with first bad commit reverted
>> git bisect good 90d0ce801fac8115d424e40a4a258aeed0e409dd  # 03:58  G    302     0    7   7  Revert "x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32"
>> # extra tests on tree/branch tip/master
>> git bisect  bad 4edd5aa38cec47346e0d0a85fa43964828b982d0  # 04:37  B    257     1    5   6  Merge branch 'linus'
>
>May I ask how this was bisected? I found it very hard to reproduce, it
>triggered less then two times a day with the attached reproducer. Given
>that the report came pretty fast after the patches landed in
>tip/x86/pti, I guess it triggered a lot faster in your testing.
>

There is higher reproduce rate (2/310) in 0day environment, and we got dozens
of qemu running simultaneously for bisection thus can get bisect result promptly.

Thanks,
Xiaolong

>Regards,
>
>	Joerg
>
>_______________________________________________
>LKP mailing list
>LKP at lists.01.org
>https://lists.01.org/mailman/listinfo/lkp
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
