From: paul@paul-moore.com (Paul Moore)
Date: Mon, 9 Oct 2017 14:21:16 -0400
Subject: [PATCH] selinux: check CAP_SETFCAP for a particular inode &
	mapped user
In-Reply-To: <1507572892.23600.10.camel@v3.sk>
References: <20171005061611.6649-1-lkundrak@v3.sk>
	<20171005064826.GA11630@mail.hallyn.com>
	<1507572892.23600.10.camel@v3.sk>
Message-ID: <CAHC9VhSQbR4AN5VZE1cuNBFL=9MqXsOUWwSw3tm93x0qxzHg6Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 9, 2017 at 2:14 PM, Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Thu, 2017-10-05 at 01:48 -0500, Serge E. Hallyn wrote:
>> On Thu, Oct 05, 2017 at 08:16:11AM +0200, Lubomir Rintel wrote:
>> > This allows setting "security.capability" xattr by a user that has
>> > CAP_SETFCAP in an userns with SELinux. Namespaced capabilities are
>> > supported, as of commit 8db6c34f1dbc ("Introduce v3 namespaced file
>> > capabilities").
>> >
>> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>>
>> The fix is already on its way into the kernel - see the thread at
>> https://marc.info/?l=selinux&m=150713903925728&w=2
>
> Thanks for the response. I'm wondering if there are chances this could
> go to 4.14, given the patch that got merged seems reasonably self-
> contained, quite useful, and the release is going to be a long-term
> one.
>
> If rc5 is too late for such changes, are there changes it could perhaps
> go to a subsequent -stable release?

As a general rule I only send fixes, not new functionality, upwards
during the -rcX releases and this falls into the "functionality" not
"fix" category of patches.  I apply a similar approach to -stable
kernels.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
