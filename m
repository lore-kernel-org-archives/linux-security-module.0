From: alban@kinvolk.io (Alban Crequy)
Date: Mon, 22 Jan 2018 10:16:07 +0100
Subject: [RFC PATCH v2] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
In-Reply-To: <1516380970.3772.112.camel@linux.vnet.ibm.com>
References: <20180116151000.443-1-alban@kinvolk.io>
	<1516310702.3772.11.camel@linux.vnet.ibm.com>
	<CADZs7q4StoPLD4-CSXp5DkgPh29vrZWjayTAYkMAsrDychLOoQ@mail.gmail.com>
	<1516380970.3772.112.camel@linux.vnet.ibm.com>
Message-ID: <CADZs7q68zORejnVBfQ38K6PtUTj_5OqkYjMvTa=Fi+UEyPp+FQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jan 19, 2018 at 5:56 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2018-01-19 at 11:35 +0100, Alban Crequy wrote:
>> On Thu, Jan 18, 2018 at 10:25 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> > On Tue, 2018-01-16 at 16:10 +0100, Alban Crequy wrote:
>> >> From: Alban Crequy <alban@kinvolk.io>
>> >>
>> >> This patch forces files to be re-measured, re-appraised and re-audited
>> >> on file systems with the feature flag FS_NO_IMA_CACHE. In that way,
>> >> cached integrity results won't be used.
>> >>
>> >> For now, this patch adds the new flag only FUSE filesystems. This is
>> >> needed because the userspace FUSE process can change the underlying
>> >> files at any time.
>> >
>> > Thanks, it's working nicely.
>> >
>> >
>> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> >> index 511fbaabf624..2bd7e73ebc2a 100644
>> >> --- a/include/linux/fs.h
>> >> +++ b/include/linux/fs.h
>> >> @@ -2075,6 +2075,7 @@ struct file_system_type {
>> >>  #define FS_BINARY_MOUNTDATA  2
>> >>  #define FS_HAS_SUBTYPE               4
>> >>  #define FS_USERNS_MOUNT              8       /* Can be mounted by userns root */
>> >> +#define FS_NO_IMA_CACHE              16      /* Force IMA to re-measure, re-appraise, re-audit files */
>> >>  #define FS_RENAME_DOES_D_MOVE        32768   /* FS will handle d_move() during rename() internally. */
>> >>       struct dentry *(*mount) (struct file_system_type *, int,
>> >>                      const char *, void *);
>> >>
>> >
>> > Since IMA is going to need another flag, we probably should have a
>> > consistent prefix (eg. "FS_IMA").  Maybe rename this flag to
>> > FS_IMA_NO_CACHE.
>>
>> Ok, I can rename it.
>>
>> Is there a discussion about the other IMA flag?
>
> There's not a single thread that I can point to, but more of an on
> going discussion as to what it means for a filesystem to support IMA
> and how that decision is made.
>
> - Initial measuring, verifying, auditing files
> - Safely detecting when a file changes
> - Not applicable/supported
>
> With Sascha Hauer's patch "ima: Use i_version only when filesystem
> supports it" and this patch, the second issue is addressed, but will
> cause files to be re-validated, perhaps unnecessarily, impacting
> performance.
>
> Some filesystems should not be evaluated, such as pseudo filesystems
> (eg. cgroups, sysfs, devpts, pstorefs, efivarfs, debugfs, selinux,
> smack).  Instead of defining a flag indicating whether or not IMA is
> applicable/supported, we should define a new flag, indicating whether
> it is a pseudo filesystem.  This would eliminate a large portion of at
> least the builtin IMA policy rules.

Thanks for the explanation. If that other flag is about whether it is
a pseudo filesystem, it might not have "IMA" in the name though.

>> > I'm also wondering if this change should be
>> > separated from the IMA change.
>>
>> Do you mean one patch for adding the flag and the IMA change and
>> another patch for using the flag in FUSE?
>
> The flag and FUSE usage of the flag, separately from IMA.

Ok, I will send a v3 with the 2 changes.

Alban
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
