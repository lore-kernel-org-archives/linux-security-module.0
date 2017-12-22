From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 22 Dec 2017 08:21:38 -0600
Subject: [PATCH] userns: honour no_new_privs for cap_bset during user ns
	creation/switch
In-Reply-To: <20171222021733.rerkt6mhpf3cb3oe@gordon> (Aleksa Sarai's message
	of "Fri, 22 Dec 2017 13:17:34 +1100")
References: <20171221210605.181720-1-zenczykowski@gmail.com>
	<87wp1foiwa.fsf@xmission.com>
	<CAHo-OoyrOr5jXwU-j4Z4qYdWo40+qAdAk0r+OpfMUZ6LgbS-RA@mail.gmail.com>
	<87fu83lfw5.fsf@xmission.com> <20171222021733.rerkt6mhpf3cb3oe@gordon>
Message-ID: <87r2rmg7wt.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Aleksa Sarai <asarai@suse.de> writes:

> On 2017-12-21, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Good point about CAP_DAC_OVERRIDE on files you own.
>> 
>> I think there is an argument that you are playing dangerous games with
>> the permission system there, as it isn't effectively a file you own if
>> you can't read it, and you can't change it's permissions.
>
> This problem reminds me of the whole "unmapped group" problem. If you
> have access to a file through an unmapped group you can still access a
> file -- which to me is wrong. I understand the need for checking
> unmapped groups in order to fix the "chmod 707" problem, but I think
> that unmapped groups should only *block* access and never *grant* it.
>
> I was working on a patch for that issue a while ago but it touched more
> VFS than I was comfortable with. Eric, is that a fix you would be
> interested in?

I am not certain.  I don't see how there is a problem with an unmapped
group granting permissions.  You are talking about a scenario where a
more privileged login program set your groups, and uid and gid.  The
process despite being a user namespace does not have permission to
transition them.  As such I don't see the harm.

But spell it out for me, and deal with ensuring we don't have user space
regressions and I will take a patch that improves the security of user
namespaces.

I think the issue that raised all of this is that dropping a group can
in rare instances increase permissions.  I have heard people grumble at
me that the way I handle it with /etc/subuid might break things on some
people's systems.  AKA don't allow it by default but allow root to
configure a way for people using user namespaces to do that.  I have yet
to see someone come forward and say that is a problem in the real world.
If it actually is a problem I want to hear about it.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
