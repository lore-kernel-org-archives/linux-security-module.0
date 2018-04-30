From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 30 Apr 2018 09:11:20 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
	<201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
	<0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
Message-ID: <CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 29, 2018 at 2:23 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/29/2018 4:49 AM, Tetsuo Handa wrote:
>> Casey Schaufler wrote:
>>> I think that we're on the verge of having a major merge collision.
>> I think that the reason of major merge collision is that your patchset is
>> too big to review.
>
> My patch set is large because it has to address all of the
> aspects of multiple modules running on the system before some
> important members of the community will look at it seriously.
>
>>
>>   > That's a lot of overhead. The smaller the patches, the more work
>>   > required to make the patch set. You're right that the current patches
>>   > are too big. Moving forward I will be providing smaller, easier to
>>   > deal with patches. The sheer overhead of rebaseing a large patch set
>>   > has slowed down the development considerably. Minions. What I need are
>>   > minions.
>>
>> You are holding the global lock for patchset which you did not get response.
>> If you agree with breaking into smaller patches, we will be able to solve
>> the major merge collision.
>
> I will be presenting the set of smaller patches once I finish merging
> them into 4.18. It's a bigger jobs than usual because of the change from
> lists to hlists, the significant changes to AppArmor and the early stages
> of SELinux namespacing. I hope to have it done mid week, but the changes
> need to get tested, and there are lots of configurations involved.
>
> I am perfectly amenable to the patches going in in logical stages.
> In fact, that is what I would recommend.
>
I guess I'm just a little bit frustrated, because, in my mind, some of
my patches provide immediate value, and are ready to be reviewed, and
or respun. Testuo did a good job reviewing 1-5, and I think that if
those are his only issues, then we're good to go.
I've:
1) Do safe hook loading for sane security modules (those that don't
try to overload major hooks), without compromising the security of
other hooks
2) Suggested a whitelist of major hooks to prevent insane modules from
being loaded

If Casey's patches land, we can just not do (2), and we're good to go.

>>> I hope to have the multiple major module code seriously reviewed as of
>>> 4.18 and start putting real pressure on getting it in for 4.19/4.20.
>> Before you repost your patchset, please answer questions below.
>>
>> Q1: Apart from whether memory for security blobs should be managed by
>>     infrastructure or by individual module, how do you guarantee that
>>     only release hook where corresponding alloc hook succeeded when
>>     one of alloc hooks returned an error?
>
> The infrastructure allocates a zeroed blob. Module "alloc" hooks
> are called. The module specific hooks set their data as desired.
> If a module alloc hook fails the complete set of free hooks can
> be called because the module data will either have been set or
> will be still be zeroed. This means that module free hooks have
> to accommodate the possibility the the module specific data was
> never set.
>
> The reality is that many of the free hooks go away with the
> infrastructure blob management. Those that remain can easily
> be confirmed to be safe in the case where all the modules data
> is NULL.
>
>
>> My patch 1/2 provides that mechanism. Please show your patch which
>> implements only that functionality instead of whole patchset.
>
> It's not an explicit change. It is an artifact of the infrastructure
> allocating and freeing the data. You can't tease the removal of the
> module free hooks apart from the infrastructure freeing the data.
>
>>   > It is my firm hope that the multiple major module changes are
>>   > going to start being seriously considered in the next release or
>>   > two. That would reduce the complexity of what you're trying to
>>   > accomplish because at the point all modules will be equal. I have
>>   > always committed to making design choices that aren't going to
>>   > prevent loadable/unloadable modules. I have also expressed no
>>   > interest in doing it myself. From my selfish perspective I would
>>   > like to see module loading follow my work, as having yet another
>>   > major merge effort will delay the clean-up I know I'll have to do
>>   > after 4.18.
>>
>> Depending on your patch, it is possible that managing memory for security
>> blobs by infrastructure can become harmful for LKM-based LSMs, for the
>> amount of memory which will be needed by LKM-based LSMs is not known
>> until LKM-based LSMs are loaded.
>
> It's certainly not more "harmful" than the single blob mechanism we
> have now. The patches I'm proposing don't make the situation any worse
> than it is today. As I've maintained all along, I'm not trying to
> address LKM-based modules.
>
> There is no reason I can see that blob sizes couldn't change while
> a system is running (yes, I have looked into it) provided that the
> blob size and content list is recorded in the blob and that the dynamic
> modules check this information before trying to use it.
>
>         smack_inode(struct inode *inode)
>         {
>                 return inode->i_security + smack_blob_sizes.lbs_inode;
>         }
>
>         lkm_based_module_inode(struct inode *inode)
>         {
>                 struct lsm_inode_blob_header *ibh = inode->security;
>                 if (some_appropriate_check(ibh, LKM_BASED_MODULE_ID))
>                         return inode->i_security + lkm_based_module_blob_sizes.lbs_inode;
>                 /* No blob for this object */
>                 return NULL;
>         }
>
> A refinement to this might keep the offset for dynamic module data
> in the blob header. That would be more flexible, but would consume
> more memory for each blob.
>
>> LKM-based LSMs might be forced to manage their security blobs without
>> using infrastructure-managed ->security field. Then, that will not make
>> "all modules equal".
>
> Regardless of how the data is managed the information about how much
> is being used and where to find it has to be kept somewhere. With
> static modules it is easier because you only need to figure that out
> once, at the beginning. If you're going to have blob data changing
> you have to look it up or figure it out at every reference. It's
> not impossible. It's not even really that hard, but it won't be
> cheap.
>
>> So, please show your approach which allows LKM-based LSMs to handle
>> infrastructure-managed ->security field (if you want to use
>> infrastructure-managed ->security field).
>
> I'll repeat, I don't have code to do it because I have explicitly
> excluded lkm-based modules from my todo list. If I were doing it,
> I would propose an infrastructure managed header in the security
> blobs containing sufficient information for the modules to determine
> if the data they are looking for is present. lkm-based modules would
> have to be coded to accept that they might get blobs that were created
> before the module was loaded, and that do not contain data for that
> module.
>
> The blob header mechanism would only be included if lkm-based security
> module support was configured.
>
>>> The advent of the Age of Containers is driving this.
>> I've been asking for runtime loading of LSMs before the Age of
>> Containers comes. ;-)
>
> Yes, you have!
>
>> Q2: What functionality are Containers people want LSM?
>
> It varies. Container people are a diverse lot.
>
>>     Use different LSM module for different container?
>
One dumb use case I have is the ability to limit interactions with
PTYs for containerized applications. Another aspect of this is being
able to write policies in C, and actually being able to control the
nitty gritty of what's going on, versus actively fighting with the
LSM(s).

> That is definitely one use case. You might run Smack on the base
> system and label each container based on who payed for it, and
> let the security module set within the container be whatever the
> job demands.
>
>>     Runtime load/unload of LSM modules?
>
> I would see that as something you might do on container
> startup, but managing the module set could get ugly.
>
I can forgo this, if neccessary. I see benefits around it for surgical
fixes, specifically, CVEs, but I can understand if it's not worth the
complexity tradeoff.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
