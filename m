From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Thu, 29 Jun 2017 21:39:20 +0200
Subject: [RFC v2 5/9] S.A.R.A. WX Protection
In-Reply-To: <CAGXu5jJuQx2qOt_aDqDQDcqGOZ5kmr5rQ9Zjv=MRRCJ65ERfGw@mail.gmail.com>
References: <1497544976-7856-1-git-send-email-s.mesoraca16@gmail.com>
	<1497544976-7856-6-git-send-email-s.mesoraca16@gmail.com>
	<CAGXu5jJuQx2qOt_aDqDQDcqGOZ5kmr5rQ9Zjv=MRRCJ65ERfGw@mail.gmail.com>
Message-ID: <CAJHCu1Lr9KOdheHMO6tkaatizDpcgjAd3ouxiUxSeVyQPpkXOg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-28 1:04 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Thu, Jun 15, 2017 at 9:42 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> +static int sara_check_vmflags(vm_flags_t vm_flags)
>> +{
>> +       u16 sara_wxp_flags = get_current_sara_wxp_flags();
>> +
>> +       if (sara_enabled && wxprot_enabled) {
>> +               if (sara_wxp_flags & SARA_WXP_WXORX &&
>> +                   vm_flags & VM_WRITE &&
>> +                   vm_flags & VM_EXEC) {
>> +                       if ((sara_wxp_flags & SARA_WXP_VERBOSE))
>> +                               pr_wxp("W^X");
>> +                       if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))
>> +                               return -EPERM;
>> +               }
>> +               if (sara_wxp_flags & SARA_WXP_MMAP &&
>> +                   (vm_flags & VM_EXEC ||
>> +                    (!(vm_flags & VM_MAYWRITE) && (vm_flags & VM_MAYEXEC))) &&
>> +                   get_current_sara_mmap_blocked()) {
>> +                       if ((sara_wxp_flags & SARA_WXP_VERBOSE))
>> +                               pr_wxp("executable mmap");
>> +                       if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))
>> +                               return -EPERM;
>> +               }
>> +       }
>
> Given the subtle differences between these various if blocks (here and
> in the other hook), I think it would be nice to have some beefy
> comments here to describe specifically what's being checked (and why).
> It'll help others review this code, and help validate code against
> intent.
>
> I would also try to minimize the written code by creating a macro for
> a repeated pattern here:
>
>> +                               if ((sara_wxp_flags & SARA_WXP_VERBOSE))
>> +                                       pr_wxp("mprotect on file mmap");
>> +                               if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))
>> +                                       return -EACCES;
>
> These four lines are repeated several times with only the const char *
> and return value changing. Perhaps something like:
>
> #define sara_return(err, msg) do { \
>                                if ((sara_wxp_flags & SARA_WXP_VERBOSE)) \
>                                        pr_wxp(err); \
>                                if (!(sara_wxp_flags & SARA_WXP_COMPLAIN)) \
>                                        return -err; \
> } while (0)
>
> Then each if block turns into something quite easier to parse:
>
>                if (sara_wxp_flags & SARA_WXP_WXORX &&
>                    vm_flags & VM_WRITE &&
>                    vm_flags & VM_EXEC)
>                        sara_return(EPERM, "W^X");

I absolutely agree with all of the above. These issues will be addressed in v3.
Thank you for your contribution.

Salvatore
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
