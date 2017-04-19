From: keescook@chromium.org (Kees Cook)
Date: Wed, 19 Apr 2017 16:43:18 -0700
Subject: [PATCH v3 2/2] modules:capabilities: add a per-task modules
	autoload restriction
In-Reply-To: <CALCETrXFp-apnfRPg9qx6E7g3KDU8DanBW1pMUnA1zShrB5xKg@mail.gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-3-git-send-email-tixxdz@gmail.com>
	<CALCETrXFp-apnfRPg9qx6E7g3KDU8DanBW1pMUnA1zShrB5xKg@mail.gmail.com>
Message-ID: <CAGXu5jJ5dm8yJJ34tEyOP78OxUr2awXmNhm6RaVP8jE4q+L5Ng@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 19, 2017 at 4:15 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Apr 19, 2017 at 3:20 PM, Djalal Harouni <tixxdz@gmail.com> wrote:
>> +/* Sets task's modules_autoload */
>> +static inline int task_set_modules_autoload(struct task_struct *task,
>> +                                           unsigned long value)
>> +{
>> +       if (value > MODULES_AUTOLOAD_DISABLED)
>> +               return -EINVAL;
>> +       else if (task->modules_autoload > value)
>> +               return -EPERM;
>> +       else if (task->modules_autoload < value)
>> +               task->modules_autoload = value;
>> +
>> +       return 0;
>> +}
>
> This needs to be more locked down.  Otherwise someone could set this
> and then run a setuid program.  Admittedly, it would be quite odd if
> this particular thing causes a problem, but the issue exists
> nonetheless.

Eeeh, I don't agree this needs to be changed. APIs provided by modules
are different than the existing privilege-manipulation syscalls this
concern stems from. Applications are already forced to deal with
things being missing like this in the face of it simply not being
built into the kernel.

Having to hide this behind nnp seems like it'd reduce its utility...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
