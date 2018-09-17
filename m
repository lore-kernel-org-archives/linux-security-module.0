From: john.johansen@canonical.com (John Johansen)
Date: Mon, 17 Sep 2018 12:35:35 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
	<35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
	<CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
	<8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
	<CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
Message-ID: <55196153-7a01-4555-623b-7e3292475f04@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/17/2018 11:14 AM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 10:13 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> TOMOYO uses the cred blob pointer. When the blob is shared TOMOYO
>> has to be allocated a pointer size chunk to store the pointer in.
>> Smack has the same behavior on file blobs.
> 
> Oh dang, yes, I got confused over secid and other "extreme" shared things.
> 
> So one change of my series would be to declare tomoyo as "exclusive" too.
> 
>> Today the distinction is based on how the module registers hooks.
>> Modules that use blobs (including TOMOYO) use security_module_enable()
>> and those that don't just use security_add_hooks(). The "pick one"
>> policy is enforced in security_module_enable(), which is why you can
>> have as many non-blob users as you like. You could easily have a
>> non-blob using module that was exclusive simply by using
>> security_module_enable().
> 
> True. With my removal of security_module_enable(), yes, it makes sense
> to mark all LSMs that were calling it before as exclusive, rather than
> focusing on whether they would be exclusive under the blob-sharing
> situation.
> 
>> Keep security=$lsm with the existing exclusive behavior.
>> Add lsm=$lsm1,...,$lsmN which requires a full list of modules
>>
>> If you want to be fancy (I don't!) you could add
>>
>> lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
>> lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack
> 
> We've got two issues: ordering and enablement. It's been strongly
> suggested that we should move away from per-LSM enable/disable flags
> (to which I agree). If ordering should be separate from enablement (to
> avoid the "booted kernel with new LSM built in, but my lsm="..." line
> didn't include it so it's disabled case), then I think we need to
> split the logic (otherwise we just reinvented "security=" with similar
> problems).
> 
> Should "lsm=" allow arbitrary ordering? (I think yes.)
> yes

> Should "lsm=" imply implicit enable/disable? (I think no: unlisted
> LSMs are implicitly auto-appended to the explicit list)
> 

maybe, adding $lsm to the list could possibly considered as enabling it,
but not having it there doesn't necessarily imply it isn't

> So then we could have "lsm.enable=..." and "lsm.disable=...".
> 
> If builtin list was:
> capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
> then:
> 
>     lsm.disable=loadpin lsm=smack
> 
> becomes
> 
>     capability,smack,yama,integrity
> 
> and
> 
>     CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=n
>     selinux.enable=0 lsm.add=loadpin lsm.disable=smack,tomoyo lsm=integrity
> 
> becomes
> 
>     capability,integrity,yama,loadpin,apparmor
> 
> 
> If "lsm=" _does_ imply enablement, then how does it interact with
> per-LSM disabling? i.e. what does "apparmor.enabled=0
> lsm=yama,apparmor" mean? If it means "turn on apparmor" how do I turn
> on a CONFIG-default-off LSM without specifying all the other LSMs too?
> 

currently using

   security=apparmor apparmor=0

means apparmor is the one given the chance to register but it declines
which means you just get capabilities. And with

   # caveat not part of the current stacking patchset
   security=selinux,apparmor  apparmor=0

you end up with

   capability,selinux

However apparmor=1 does not imply apparmor is the available LSM

that is

   security=selinux  apparmor=1

gives you
   
   capability,selinux

if iirc selinux=X behaves the same way

However it is not clear to me whether this is the behavior that we
would want for $lsm.enabled, $lsm.disabled. It appears to be in
conflict with how yama, loadpin and IMA currently work.
