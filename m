From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Thu, 29 Jun 2017 21:28:11 +0200
Subject: [RFC v2 3/9] Creation of "check_vmflags" LSM hook
In-Reply-To: <CAGXu5jJTEoeGs8uBdHYdBJwacOp2b22ySrn-V8T93qaD4cv65A@mail.gmail.com>
References: <1497544976-7856-1-git-send-email-s.mesoraca16@gmail.com>
	<1497544976-7856-4-git-send-email-s.mesoraca16@gmail.com>
	<CAGXu5jJTEoeGs8uBdHYdBJwacOp2b22ySrn-V8T93qaD4cv65A@mail.gmail.com>
Message-ID: <CAJHCu1JMdBCPgpL=vCqOKD1y4fK5Y3qoWOdXCy-qDw-ixV0Lmg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-28 1:05 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Thu, Jun 15, 2017 at 9:42 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> Creation of a new LSM hook to check if a given configuration of vmflags,
>> for a new memory allocation request, should be allowed or not.
>> It's placed in "do_mmap", "do_brk_flags" and "__install_special_mapping".
>
> I like this. I think this is something the other LSMs should be
> checking too. (Though I wonder if it would be helpful to include the
> VMA in the hook, though it does exist yet, so... hmm.)

For the particular case of my LSM and the type of check it does, the VMA
isn't needed, of course.
Maybe some other LSM can benefit from it, but it depends on what they
want to do with this hook.
Looking forward to feedback from potential future users.
Thank you for your interest.

Salvatore
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
