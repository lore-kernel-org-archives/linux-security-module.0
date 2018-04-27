From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 27 Apr 2018 13:59:57 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn9kAzdTyyinSZB0VtuGzc7KaKMQg9Ym+Xw4F6MgQTVUCQ@mail.gmail.com>
References: <cover.1524645853.git.sargun@sargun.me>
	<CAMp4zn9kAzdTyyinSZB0VtuGzc7KaKMQg9Ym+Xw4F6MgQTVUCQ@mail.gmail.com>
Message-ID: <e362a7e8-a778-7701-9254-d531949dd5c2@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/27/2018 1:32 PM, Sargun Dhillon wrote:
> On Wed, Apr 25, 2018 at 1:58 AM, Sargun Dhillon <sargun@sargun.me> wrote:
>> The primary security benefit of this patchset is the introduction of
>> read-only hooks, even if some security modules have mutable hooks.
>> ...
>>
> James, Casey,
> Should I respin patches 1-5 with the fixes that Tetsuo suggested, and
> do you want to pick those up? It seems like other than the few errors,
> those look good. And then we can figure out to deal with patch 6
> later?

It is my firm hope that the multiple major module changes are
going to start being seriously considered in the next release or
two. That would reduce the complexity of what you're trying to
accomplish because at the point all modules will be equal. I have
always committed to making design choices that aren't going to
prevent loadable/unloadable modules. I have also expressed no
interest in doing it myself. From my selfish perspective I would
like to see module loading follow my work, as having yet another
major merge effort will delay the clean-up I know I'll have to do
after 4.18.

My suggestion/request would be that you rebase your patches on
the stacking set, which should be out for 4.18 mid-week.



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
