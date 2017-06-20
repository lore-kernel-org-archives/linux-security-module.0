From: john.johansen@canonical.com (John Johansen)
Date: Tue, 20 Jun 2017 15:28:58 -0700
Subject: [PATCH v2] apparmor: add braces around optional statement
In-Reply-To: <20170620204953.GA25573@mail.hallyn.com>
References: <20170620204722.910610-1-arnd@arndb.de>
	<20170620204953.GA25573@mail.hallyn.com>
Message-ID: <646e7518-4aa1-e1ff-49bd-0f0c842d38bc@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/20/2017 01:49 PM, Serge E. Hallyn wrote:
> Quoting Arnd Bergmann (arnd at arndb.de):
>> We get a warning when AA_BUG() compiles to an nothing:
>>
>> security/apparmor/label.c: In function '__label_update':
>> security/apparmor/label.c:2055:3: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>>
>> There are two things we can do about this:
>>
>> - add the missing braces in the call site, which also
>>   brings the code in line with the regular Linux coding style
>>
>> - redefine the macro so it is not empty but instead uses
>>   no_printk() in AA_BUG_FMT() to perform format checking.
>>
>> Both seem like good ideas, so this does both at once.
>>
>> Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> 
>> --
>> v2: actually include the second part of the patch
>> ---
>>  security/apparmor/include/lib.h | 2 +-
>>  security/apparmor/label.c       | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
>> index 436b3a722357..cbfb71c1ec88 100644
>> --- a/security/apparmor/include/lib.h
>> +++ b/security/apparmor/include/lib.h
>> @@ -50,7 +50,7 @@
>>  #define AA_BUG_FMT(X, fmt, args...)					\
>>  	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
>>  #else
>> -#define AA_BUG_FMT(X, fmt, args...)
>> +#define AA_BUG_FMT(X, fmt, args...) no_printk("%s" fmt, __func__, ##args)
>>  #endif
>>  
>>  #define AA_ERROR(fmt, args...)						\
>> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
>> index e052eaba1cf6..f8e08d94a8a6 100644
>> --- a/security/apparmor/label.c
>> +++ b/security/apparmor/label.c
>> @@ -2051,8 +2051,9 @@ static struct aa_label *__label_update(struct aa_label *label)
>>  			write_lock_irqsave(&ls->lock, flags);
>>  			goto remove;
>>  		}
>> -	} else
>> +	} else {
>>  		AA_BUG(labels_ns(label) != labels_ns(new));
>> +	}
>>  
>>  	tmp = __label_insert(labels_set(label), new, true);
>>  remove:
>> -- 
>> 2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
