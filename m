From: tixxdz@gmail.com (Djalal Harouni)
Date: Fri, 10 Nov 2017 11:33:47 +0100
Subject: [PATCH RFC v3 4/7] proc: support mounting private procfs
	instances inside same pid namespace
In-Reply-To: <alpine.LFD.2.20.1711101352580.8844@localhost>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-5-git-send-email-tixxdz@gmail.com>
	<alpine.LFD.2.20.1711101352580.8844@localhost>
Message-ID: <CAEiveUfOoQVNnq0tRVEDJsqBHX99uMHwK3eRJKneuh+ERo7D6w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Nov 10, 2017 at 3:53 AM, James Morris <james.l.morris@oracle.com> wrote:
> On Thu, 9 Nov 2017, Djalal Harouni wrote:
>
>> This should allow later after real testing to have a smooth transition
>> to a procfs with default private instances.
>>
>> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-January/004215.html
>> [2] http://www.openwall.com/lists/kernel-hardening/2017/10/05/5
>> [3] https://lwn.net/Articles/689539/
>> [4] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
>> [5] https://lkml.org/lkml/2017/5/2/407
>> [6] https://lkml.org/lkml/2017/5/3/357
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
>> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
>
>
> Reviewed-by: James Morris <james.l.morris@oracle.com>

Thank you James!


-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
