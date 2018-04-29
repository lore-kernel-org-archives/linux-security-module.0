From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 29 Apr 2018 20:49:45 +0900
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
Message-ID: <201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> I think that we're on the verge of having a major merge collision.

I think that the reason of major merge collision is that your patchset is
too big to review.

  > That's a lot of overhead. The smaller the patches, the more work
  > required to make the patch set. You're right that the current patches
  > are too big. Moving forward I will be providing smaller, easier to
  > deal with patches. The sheer overhead of rebaseing a large patch set
  > has slowed down the development considerably. Minions. What I need are
  > minions.

You are holding the global lock for patchset which you did not get response.
If you agree with breaking into smaller patches, we will be able to solve
the major merge collision.

> I hope to have the multiple major module code seriously reviewed as of
> 4.18 and start putting real pressure on getting it in for 4.19/4.20.

Before you repost your patchset, please answer questions below.

Q1: Apart from whether memory for security blobs should be managed by
    infrastructure or by individual module, how do you guarantee that
    only release hook where corresponding alloc hook succeeded when
    one of alloc hooks returned an error?

My patch 1/2 provides that mechanism. Please show your patch which
implements only that functionality instead of whole patchset.

  > It is my firm hope that the multiple major module changes are
  > going to start being seriously considered in the next release or
  > two. That would reduce the complexity of what you're trying to
  > accomplish because at the point all modules will be equal. I have
  > always committed to making design choices that aren't going to
  > prevent loadable/unloadable modules. I have also expressed no
  > interest in doing it myself. From my selfish perspective I would
  > like to see module loading follow my work, as having yet another
  > major merge effort will delay the clean-up I know I'll have to do
  > after 4.18.

Depending on your patch, it is possible that managing memory for security
blobs by infrastructure can become harmful for LKM-based LSMs, for the
amount of memory which will be needed by LKM-based LSMs is not known
until LKM-based LSMs are loaded.

LKM-based LSMs might be forced to manage their security blobs without
using infrastructure-managed ->security field. Then, that will not make
"all modules equal".

So, please show your approach which allows LKM-based LSMs to handle
infrastructure-managed ->security field (if you want to use
infrastructure-managed ->security field).

> The advent of the Age of Containers is driving this.

I've been asking for runtime loading of LSMs before the Age of
Containers comes. ;-)

Q2: What functionality are Containers people want LSM?
    Use different LSM module for different container?
    Runtime load/unload of LSM modules?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
