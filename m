From: sargun@sargun.me (Sargun Dhillon)
Date: Fri, 27 Apr 2018 13:21:43 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
References: <201804260715.w3Q7FOlb036047@www262.sakura.ne.jp>
	<CAMp4zn9ojWn5oNMgZ6OKQR4=JhSnsrCzO443a8A71xfo_eLzHA@mail.gmail.com>
	<201804262107.HGG56259.OFOtHSOFQLVFJM@I-love.SAKURA.ne.jp>
	<CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
Message-ID: <CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 27, 2018 at 6:25 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Sargun Dhillon wrote:
>> > inode_free_security is called on all LSM callbacks -- so, it should
>> > be, as long as people don't load unloadable major LSMs. If we want to
>> > be super conservative here, we can do a try_module_get, and a
>> > module_put if RC != 0 on RW hooks. So, we could have something like
>> > call_int_hook_major, and call_void_hook_major.
>
> I don't think we want to play with module usage count.
>
>> >
>> >>         }
>> >>         /*** End of changes made by this series ***/
>> >>         return 0;
>> >> }
>> >>
>> >> and what Casey's series is doing is
>> >>
>> >> int security_inode_alloc(struct inode *inode)
>> >> {
>> >>         struct security_hook_list *P;
>> >>         inode->i_security = NULL;
>> >>         hlist_for_each_entry(P, &security_hook_heads.inode_alloc_security, list) {
>> >>                 int RC = P->hook.inode_alloc_security(inode);
>> >>                 if (RC != 0) {
>> >>                         /*** Start of changes made by Casey's series ***/
>> >>                         hlist_for_each_entry(P, &security_hook_heads.inode_free_security, list) {
>> >>                                 P->hook.inode_free_security(inode); // <= Might call inode_free_security() without corresponding successful inode_alloc_security().
>> >>                         }
>> >>                         /*** End of changes made by Casey's series ***/
>> >>                         return RC;
>> >>                 }
>> >>         }
>> >>         return 0;
>> >> }
>> > Right, but this could be taken care of by just ensuring that nobody
>> > allocates blobs (major LSM), and only one LSM returns a non-zero to
>> > the *alloc* callbacks? Right now, we have this because one has to be a
>> > "major" LSM in order to use these callbacks, and we ensure only one
>> > major LSM is active at a time.
>
> What Casey is trying to do is allow multiple major modules to use their
> own blob. Thus,
>
>> >
>> > I suggest that either in the short term we:
>> > 1) Trust people not to load a second major LSM,
>
> this is not an option.
>
This is exactly what people do today?
>> > 2) See below.
>> >
>> > What about something as stupid as:
>
> I don't think we want to do this.
>
We have the limit today of not allowing people to load two major LSMs.
Why not wait till later to solve this problem, and for now, reject
when people install two major LSMs? I think we can fix the dynamic
loading problem _first_ and the multiple major LSM problem _second_

>> One other aspect that may not be obvious is on the *_alloc_*,
>> callbacks, we wouldn't want to call callback's of LSMs which are
>> non-major.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
