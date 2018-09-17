From: penguin-kernel@i-love.sakura.ne.jp (Tetsuo Handa)
Date: Mon, 17 Sep 2018 09:46:58 +0900
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
Message-ID: <e6e7521f-7810-a938-3f0e-daefb6579344@i-love.sakura.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2018/09/17 8:00, Kees Cook wrote:
> On Sun, Sep 16, 2018 at 11:49 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> One solution is to leave security= as is, not affecting "minor"
>> modules and only allowing specification of one major module, and adding
> 
> I would much prefer this, yes.
> 
> A question remains: how do we map the existing "security=" selection
> of a "major" LSM against what will be next "exclusive" plus tomoyo,
> and in the extreme case, nothing?
> 
> Perhaps as part of deprecating "security=", we could just declare that
> it is selecting between SELinux, AppArmor, Smack, and Tomoyo only?
> 
>> another boot option security.stack= that overrides a security= option
>> and that takes the list as you've implemented here.
> 
> or "lsm.stack=" that overrides "security=" entirely?


Yes, I think we can add new option.

For example, introducing lsm= and obsoleting security= (because total length for
kernel command line is limited while enumeration makes the parameter value longer).

  security= works like current behavior.

  lsm= requires explicit enumeration of all modules (except capability which has to
  be always enabled) which should be enabled at boot.

  security= is ignored if lsm= is specified.
