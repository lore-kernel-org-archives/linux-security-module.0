From: nicolas@belouin.fr (Nicolas Belouin)
Date: Sat, 21 Oct 2017 20:41:58 +0200
Subject: [kernel-hardening] [RFC PATCH 1/2] security,
	capabilities: Add CAP_SYS_MOUNT
In-Reply-To: <edfdfc70-fd07-4930-c7f5-0d2b6355b09b@schaufler-ca.com>
References: <20171021134303.20685-1-nicolas@belouin.fr>
	<edfdfc70-fd07-4930-c7f5-0d2b6355b09b@schaufler-ca.com>
Message-ID: <AED1D433-EDCE-4B0B-AB8D-55627E5B94A4@belouin.fr>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On October 21, 2017 7:31:24 PM GMT+02:00, Casey Schaufler <casey@schaufler-ca.com> wrote:
>On 10/21/2017 6:43 AM, Nicolas Belouin wrote:
>> With CAP_SYS_ADMIN being bloated and inapropriate for actions such
>> as mounting/unmounting filesystems, the creation of a new capability
>> is needed.
>> CAP_SYS_MOUNT is meant to give a process the ability to call for
>mount,
>> umount and umount2 syscalls.
>
>This is increased granularity for it's own sake. There is no
>compelling reason to break out this capability in particular.

Obviously there is a need to break CAP_SYS_ADMIN in pieces, to do so, you have to start somewhere, so I chose to begin with this.

>Can you identify existing use cases where you would have
>CAP_SYS_MOUNT without also having CAP_SYS_ADMIN? I should think
>that all the work that's gone into unprivileged mounts over
>the past couple years would make this unnecessary.

If you look at the udiskd deamon used by most desktop environments, it is launched as root or at least with CAP_SYS_ADMIN. Here, you could use CAP_SYS_MOUNT. There might also be a use within containers as you don't want to give CAP_SYS_ADMIN to a container if it just need to mount/unmount filesystems. If you go even further, it could be used to allow swapon/swapoff (maybe in future patch set).

>
>> Signed-off-by: Nicolas Belouin <nicolas@belouin.fr>
>> ---
>>  include/uapi/linux/capability.h     | 5 ++++-
>>  security/selinux/include/classmap.h | 4 ++--
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/capability.h
>b/include/uapi/linux/capability.h
>> index 230e05d35191..ce230aa6d928 100644
>> --- a/include/uapi/linux/capability.h
>> +++ b/include/uapi/linux/capability.h
>> @@ -365,8 +365,11 @@ struct vfs_ns_cap_data {
>>  
>>  #define CAP_AUDIT_READ		37
>>  
>> +/* Allow mounting, unmounting filesystems */
>>  
>> -#define CAP_LAST_CAP         CAP_AUDIT_READ
>> +#define CAP_SYS_MOUNT		38
>> +
>> +#define CAP_LAST_CAP         CAP_SYS_MOUNT
>>  
>>  #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>>  
>> diff --git a/security/selinux/include/classmap.h
>b/security/selinux/include/classmap.h
>> index 35ffb29a69cb..a873dce97fd5 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -24,9 +24,9 @@
>>  	    "audit_control", "setfcap"
>>  
>>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>> -		"wake_alarm", "block_suspend", "audit_read"
>> +		"wake_alarm", "block_suspend", "audit_read", "sys_mount"
>>  
>> -#if CAP_LAST_CAP > CAP_AUDIT_READ
>> +#if CAP_LAST_CAP > CAP_SYS_MOUNT
>>  #error New capability defined, please update COMMON_CAP2_PERMS.
>>  #endif
>>  

Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
