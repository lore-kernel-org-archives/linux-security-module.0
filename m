From: keescook@chromium.org (Kees Cook)
Date: Fri, 2 Feb 2018 08:11:15 +1100
Subject: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-4-igor.stoppa@huawei.com>
	<alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
	<48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
Message-ID: <CAGXu5jKKeJL13dcaY=fDJ8AiOXDP5MhQTqDYDOt3a374CFA1HQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Feb 1, 2018 at 11:42 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 01/02/18 02:00, Christopher Lameter wrote:
>> Would it not be better to use compound page allocations here?
>> page_head(whatever) gets you the head page where you can store all sorts
>> of information about the chunk of memory.
>
> Can you please point me to this function/macro? I don't seem to be able
> to find it, at least not in 4.15

IIUC, he means PageHead(), which is also hard to grep for, since it is
a constructed name, via Page##uname in include/linux/page-flags.h:

__PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
