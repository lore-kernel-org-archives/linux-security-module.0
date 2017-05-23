From: john.johansen@canonical.com (John Johansen)
Date: Tue, 23 May 2017 11:51:15 -0700
Subject: [PATCH] apparmor: Fix error cod in __aa_fs_profile_mkdir()
In-Reply-To: <59245318.4000809@bfs.de>
References: <20170523143346.GB28152@elgon.mountain> <59245318.4000809@bfs.de>
Message-ID: <f98f9648-1868-0c26-6b4f-2ffd33daf781@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/23/2017 08:19 AM, walter harms wrote:
> 
> 
> Am 23.05.2017 16:33, schrieb Dan Carpenter:
>> We can either return PTR_ERR(NULL) or a PTR_ERR(a valid pointer) here.
>> Returning NULL is probably not good, but since this happens at boot
>> then we are probably already toasted if we were to hit this bug in real
>> life.  In other words, it seems like a very low severity bug to me.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
>> index 4f6ac9dbc65d..18f0d105084d 100644
>> --- a/security/apparmor/apparmorfs.c
>> +++ b/security/apparmor/apparmorfs.c
>> @@ -728,8 +728,10 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
>>  		id_len = snprintf(NULL, 0, ".%ld", profile->ns->uniq_id);
>>  
>>  		profile->dirname = kmalloc(len + id_len + 1, GFP_KERNEL);
>> -		if (!profile->dirname)
>> -			goto fail;
>> +		if (!profile->dirname) {
>> +			error = -ENOMEM;
>> +			goto fail2;
>> +		}
>>  
>>  		mangle_name(profile->base.name, profile->dirname);
>>  		sprintf(profile->dirname + len, ".%ld", profile->ns->uniq_id++);
> 
> Can mangle_name made to return a propper string ?
> IFF this can be reduced to
> 	profile->dirname =kasprintf(GFP_KERNEL,"%s.%ld",mangle_name(),profile->ns->uniq_id);
> 	if (!profile->dirname) ....
> 
> just a hint.
> 
something of the sort could be done, but you would need to track the allocation returned
from mangle_name so that it can be freed. But we can take this whole sequence and shove
it into mangle_name and have it do the allocation, and return a string. It would clean
things up. I'll cons together a patch for the next pull request.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
