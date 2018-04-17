From: paul@paul-moore.com (Paul Moore)
Date: Tue, 17 Apr 2018 17:55:40 -0400
Subject: [PATCH ghak47 V1] audit: normalize MAC_POLICY_LOAD record
In-Reply-To: <CAHC9VhTv_2ErGe38u+Z2CGY2BhNqbG0u_tqbMmwOYUsr4jJ3aQ@mail.gmail.com>
References: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
	<CAHC9VhTv_2ErGe38u+Z2CGY2BhNqbG0u_tqbMmwOYUsr4jJ3aQ@mail.gmail.com>
Message-ID: <CAHC9VhQ5513TWiUc5vCo6j=ksiVDThXaA6_XTTt-T2OvfrEOTw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 11, 2018 at 5:11 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Apr 9, 2018 at 7:36 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> The audit MAC_POLICY_LOAD record had redundant dangling keywords and was
>> missing information about which LSM was responsible and its completion
>> status.  While this record is only issued on success, the parser expects
>> the res= field to be present.
>>
>> Old record:
>> type=MAC_POLICY_LOAD msg=audit(1479299795.404:43): policy loaded auid=0 ses=1
>>
>> Delete the redundant dangling keywords, add the lsm= field and the res=
>> field.
>>
>> New record:
>> type=MAC_POLICY_LOAD msg=audit(1523293846.204:894): auid=0 ses=1 lsm=selinux res=1
>>
>> See: https://github.com/linux-audit/audit-kernel/issues/47
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> ---
>>  security/selinux/selinuxfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 00b21b2..496915a 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -531,7 +531,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>>
>>  out1:
>>         audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
>> -               "policy loaded auid=%u ses=%u",
>> +               "auid=%u ses=%u lsm=selinux res=1",
>
> This is another case of NACK on principle, but I think we can make an
> exception in this particular case.
>
> Also like the other patch, this will need to wait for the merge window
> to close before I can merge it.

Merged into selinux/next.

>>                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
>>                 audit_get_sessionid(current));
>>  out:
>> --
>> 1.8.3.1

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
