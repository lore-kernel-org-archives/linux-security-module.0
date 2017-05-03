From: keescook@chromium.org (Kees Cook)
Date: Wed, 3 May 2017 12:32:07 -0700
Subject: [PATCH v4 1/2] tiocsti-restrict : Add owner user namespace to
	tty_struct
In-Reply-To: <20170424135751.GA9030@mail.hallyn.com>
References: <20170424051512.20420-1-matt@nmatt.com>
	<20170424051512.20420-2-matt@nmatt.com>
	<20170424135751.GA9030@mail.hallyn.com>
Message-ID: <CAGXu5jLFkDB31W7uje3LaEujDrnvndQX9JK_hs47nc2dpbyNtQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 24, 2017 at 6:57 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Matt Brown (matt at nmatt.com):
>> This patch adds struct user_namespace *owner_user_ns to the tty_struct.
>> Then it is set to current_user_ns() in the alloc_tty_struct function.
>>
>> This is done to facilitate capability checks against the original user
>> namespace that allocated the tty.
>>
>> E.g. ns_capable(tty->owner_user_ns,CAP_SYS_ADMIN)
>>
>> This combined with the use of user namespace's will allow hardening
>> protections to be built to mitigate container escapes that utilize TTY
>> ioctls such as TIOCSTI.
>>
>> See: https://bugzilla.redhat.com/show_bug.cgi?id=1411256
>>
>> Signed-off-by: Matt Brown <matt@nmatt.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

This Ack didn't end up in the v5, but I think it stands, yes?

Greg, is the v5 okay to pull for you or would a v6 with Acks/Reviews
included be preferred?

-Kees

>
>> ---
>>  drivers/tty/tty_io.c | 2 ++
>>  include/linux/tty.h  | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index e6d1a65..c276814 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -171,6 +171,7 @@ static void free_tty_struct(struct tty_struct *tty)
>>       put_device(tty->dev);
>>       kfree(tty->write_buf);
>>       tty->magic = 0xDEADDEAD;
>> +     put_user_ns(tty->owner_user_ns);
>>       kfree(tty);
>>  }
>>
>> @@ -3191,6 +3192,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
>>       tty->index = idx;
>>       tty_line_name(driver, idx, tty->name);
>>       tty->dev = tty_get_device(tty);
>> +     tty->owner_user_ns = get_user_ns(current_user_ns());
>>
>>       return tty;
>>  }
>> diff --git a/include/linux/tty.h b/include/linux/tty.h
>> index 1017e904..d902d42 100644
>> --- a/include/linux/tty.h
>> +++ b/include/linux/tty.h
>> @@ -12,6 +12,7 @@
>>  #include <uapi/linux/tty.h>
>>  #include <linux/rwsem.h>
>>  #include <linux/llist.h>
>> +#include <linux/user_namespace.h>
>>
>>
>>  /*
>> @@ -333,6 +334,7 @@ struct tty_struct {
>>       /* If the tty has a pending do_SAK, queue it here - akpm */
>>       struct work_struct SAK_work;
>>       struct tty_port *port;
>> +     struct user_namespace *owner_user_ns;
>>  };
>>
>>  /* Each of a tty's open files has private_data pointing to tty_file_private */
>> --
>> 2.10.2



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
