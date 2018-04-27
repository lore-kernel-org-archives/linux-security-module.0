From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 27 Apr 2018 13:45:52 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
References: <201804260715.w3Q7FOlb036047@www262.sakura.ne.jp>
	<CAMp4zn9ojWn5oNMgZ6OKQR4=JhSnsrCzO443a8A71xfo_eLzHA@mail.gmail.com>
	<201804262107.HGG56259.OFOtHSOFQLVFJM@I-love.SAKURA.ne.jp>
	<CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
Message-ID: <a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/27/2018 1:21 PM, Sargun Dhillon wrote:
> On Fri, Apr 27, 2018 at 6:25 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Sargun Dhillon wrote:
>> ...
>>>> I suggest that either in the short term we:
>>>> 1) Trust people not to load a second major LSM,
>> this is not an option.
>>
> This is exactly what people do today?

The existing code provides no mechanism whereby multiple
"major" modules can be used at the same time. If you added
a "minor" module, and it used security blobs Bad Things(tm)
could happen.

>>>> 2) See below.
>>>>
>>>> What about something as stupid as:
>> I don't think we want to do this.
>>
> We have the limit today of not allowing people to load two major LSMs.
> Why not wait till later to solve this problem, and for now, reject
> when people install two major LSMs? I think we can fix the dynamic
> loading problem _first_ and the multiple major LSM problem _second_

I think that we're on the verge of having a major merge collision.
I hope to have the multiple major module code seriously reviewed as of
4.18 and start putting real pressure on getting it in for 4.19/4.20.
The advent of the Age of Containers is driving this.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
