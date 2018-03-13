From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 13 Mar 2018 10:46:04 -0400
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <20180312192950.GE29878@mail.hallyn.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
	<20180312192950.GE29878@mail.hallyn.com>
Message-ID: <1fd04e0e-37ab-329c-c75d-d349a3b2f136@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/12/2018 03:29 PM, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
>> Files on FUSE can change at any point in time without IMA being able
>> to detect it.  The file data read for the file signature verification
>> could be totally different from what is subsequently read, making the
>> signature verification useless.
>>
>> FUSE can be mounted by unprivileged users either today with fusermount
>> installed with setuid, or soon with the upcoming patches to allow FUSE
>> mounts in a non-init user namespace.
>>
>> This patch sets the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag and when
>> appropriate sets the SB_I_UNTRUSTED_MOUNTER flag.
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Seth Forshee <seth.forshee@canonical.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Dongsu Park <dongsu@kinvolk.io>
>> Cc: Alban Crequy <alban@kinvolk.io>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Of course when IMA namespacing hits, you'll want to compare the
> sb->s_user_ns to the (~handwaving~) user_ns owning the ima ns
> right?

I suppose this would be the only way to enable 'trusted mounters' within 
IMA namespaces. Maybe there could be an additional capability gate that 
would allow one to be a 'trusted mounter' then?

>
>> ---
>>   fs/fuse/inode.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 624f18bbfd2b..ef309958e060 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1080,6 +1080,9 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>   	sb->s_time_gran = 1;
>>   	sb->s_export_op = &fuse_export_operations;
>> +	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>> +	if (sb->s_user_ns != &init_user_ns)
>> +		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
>>   
>>   	file = fget(d.fd);
>>   	err = -EINVAL;
>> -- 
>> 2.7.5


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
