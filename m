From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 16 Sep 2018 11:49:31 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <20180916003059.1046-17-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
Message-ID: <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/15/2018 5:30 PM, Kees Cook wrote:
> To prepare for having a third type of LSM ("shared blob"), this implements
> dynamic handling of LSM ordering. The visible change here is that the
> "security=" boot commandline is now a comma-separated ordered list of
> all LSMs, not just the single "exclusive" LSM. This means that the
> "minor" LSMs can now be disabled at boot time by omitting them from the
> commandline. Additionally LSM ordering becomes entirely mutable for LSMs
> with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
> first).

Today if I have Yama enabled and use security=apparmor I get a
module list of capability,yama,apparmor. With this change I would
get a different result, capability,apparmor. I am personally OK with
this, but I think others may see it as a violation of compatibility.

One solution is to leave security= as is, not affecting "minor"
modules and only allowing specification of one major module, and adding
another boot option security.stack= that overrides a security= option
and that takes the list as you've implemented here.

An icky alternative would be to say that any security= specification
with no commas in it retains the old behavior. So
	security=apparmor
	security=apparmor,
would get you
	capability,yama,apparmor
	capability,apparmor
respectively.

Another option would be to require negation on the minor modules,
such as
	security=apparmor,-loadpin

I can't honestly say which I like least or best.
