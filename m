From: nicolas@belouin.fr (nicolas at belouin.fr)
Date: Sat, 21 Oct 2017 21:04:48 +0200
Subject: [kernel-hardening] [RFC PATCH 1/2] security,
	capabilities: create CAP_TRUSTED
In-Reply-To: <d3e1c911-138d-082a-b941-651217d0faf8@schaufler-ca.com>
References: <20171021134558.21195-1-nicolas@belouin.fr>
	<d3e1c911-138d-082a-b941-651217d0faf8@schaufler-ca.com>
Message-ID: <201710211904.v9LJ4o1X046943@smtp5.infomaniak.ch>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

<james.l.morris@oracle.com>,linux-ext4 at vger.kernel.org,linux-kernel at vger.kernel.org,linux-f2fs-devel at lists.sourceforge.net,linux-fsdevel at vger.kernel.org,linux-mtd at lists.infradead.org,jfs-discussion at lists.sourceforge.net,ocfs2-devel at oss.oracle.com,linux-unionfs at vger.kernel.org,reiserfs-devel at vger.kernel.org,linux-security-module at vger.kernel.org,selinux at tycho.nsa.gov,linux-api at vger.kernel.org,kernel-hardening at lists.openwall.com
From: Nicolas Belouin <nicolas@belouin.fr>
Message-ID: <E5A1BDA4-A309-4118-84D5-72780F619EBA@belouin.fr>



On October 21, 2017 7:25:21 PM GMT+02:00, Casey Schaufler <casey@schaufler-ca.com> wrote:
>On 10/21/2017 6:45 AM, Nicolas Belouin wrote:
>> with CAP_SYS_ADMIN being bloated, the usefulness of using it to
>> flag a process to be entrusted for e.g reading and writing trusted
>> xattr is near zero.
>> CAP_TRUSTED aims to provide userland with a way to mark a process as
>> entrusted to do specific (not specially admin-centered) actions. It
>> would for example allow a process to red/write the trusted xattrs.
>
>Please explain how this is different from CAP_MAC_ADMIN in
>any existing use case. If it is significantly different, how
>would the two interact?

>From my point of view, CAP_MAC_ADMIN allows one to read/write security xattrs, those are meant to describe security policies. As far as I know of, trusted xattrs are intended for a privileged process to read or write arbitrary data. I don't have any real world example in mind that use trusted xattrs, but I'll try to find one.

>
>> Signed-off-by: Nicolas Belouin <nicolas@belouin.fr>
>> ---
>>  include/uapi/linux/capability.h     | 6 +++++-
>>  security/selinux/include/classmap.h | 5 +++--
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/capability.h
>b/include/uapi/linux/capability.h
>> index ce230aa6d928..27e457b93c84 100644
>> --- a/include/uapi/linux/capability.h
>> +++ b/include/uapi/linux/capability.h
>> @@ -369,7 +369,11 @@ struct vfs_ns_cap_data {
>>  
>>  #define CAP_SYS_MOUNT		38
>>  
>> -#define CAP_LAST_CAP         CAP_SYS_MOUNT
>> +/* Allow read/write trusted xattr */
>> +
>> +#define CAP_TRUSTED		39
>> +
>> +#define CAP_LAST_CAP         CAP_TRUSTED
>>  
>>  #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>>  
>> diff --git a/security/selinux/include/classmap.h
>b/security/selinux/include/classmap.h
>> index a873dce97fd5..f5dc8e109f5a 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -24,9 +24,10 @@
>>  	    "audit_control", "setfcap"
>>  
>>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>> -		"wake_alarm", "block_suspend", "audit_read", "sys_mount"
>> +		"wake_alarm", "block_suspend", "audit_read", "sys_mount", \
>> +		"trusted"
>>  
>> -#if CAP_LAST_CAP > CAP_SYS_MOUNT
>> +#if CAP_LAST_CAP > CAP_TRUSTED
>>  #error New capability defined, please update COMMON_CAP2_PERMS.
>>  #endif
>>  

Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
