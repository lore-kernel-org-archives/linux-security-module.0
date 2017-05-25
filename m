From: guilherme.magalhaes@hpe.com (Magalhaes, Guilherme (Brazil R&D-CL))
Date: Thu, 25 May 2017 19:04:06 +0000
Subject: [RFC 04/11] ima: add support to namespace securityfs file
In-Reply-To: <1495712762.3841.89.camel@linux.vnet.ibm.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
	<1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
	<1495656774.3841.72.camel@linux.vnet.ibm.com>
	<d8d55872-db78-3535-a540-85c0dbb2d6fd@canonical.com>
	<1495712762.3841.89.camel@linux.vnet.ibm.com>
Message-ID: <CS1PR84MB0294089AC618EE12DB042263FFFF0@CS1PR84MB0294.NAMPRD84.PROD.OUTLOOK.COM>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi,
With the securityfs symlink we would address the case of setting policy inside containers, but we still would need a way to set the IMA policy per namespace outside containers. So, the current proposed interface would address the latter case.
As an alternative to symlinks, taking this patch set as base, and still considering setting policy inside containers (or inside namespaces in general), it is possible to bind mount the securityfs files into the containers, but it would be needed to prevent read/write access to the namespaced IMA policy files for processes not running on the same namespace.

These mechanisms would not require a change in the proposed design. Do you think these mechanisms are enough for the flexibility you asked?

Thanks.
--
Guilherme

-----Original Message-----
From: Mimi Zohar [mailto:zohar at linux.vnet.ibm.com] 
Sent: quinta-feira, 25 de maio de 2017 08:46
To: John Johansen <john.johansen@canonical.com>; Magalhaes, Guilherme (Brazil R&D-CL) <guilherme.magalhaes@hpe.com>; dmitry.kasatkin at gmail.com
Cc: viro at zeniv.linux.org.uk; james.l.morris at oracle.com; serge at hallyn.com; linux-fsdevel at vger.kernel.org; linux-kernel at vger.kernel.org; linux-ima-devel at lists.sourceforge.net; linux-ima-user at lists.sourceforge.net; linux-security-module at vger.kernel.org; tycho at docker.com; Souza, Joaquim (Brazil R&D-ECL) <joaquims@hpe.com>; Edwards, Nigel <nigel.edwards@hpe.com>
Subject: Re: [RFC 04/11] ima: add support to namespace securityfs file

Hi John,

On Thu, 2017-05-25 at 00:36 -0700, John Johansen wrote:
> On 05/24/2017 01:12 PM, Mimi Zohar wrote:
> > On Thu, 2017-05-11 at 10:59 -0300, Guilherme Magalhaes wrote:
> >> Creating the namespace securityfs file under ima folder. When a 
> >> mount namespace id is written to the namespace file, a new folder 
> >> is created and with a policy file for that specified namespace. 
> >> Then, user defined policy for namespaces may be set by writing rules to this namespace policy file.
> >> With this interface, there is no need to give visibility for the 
> >> securityfs inside mount namespaces or containers in userspace.
> >>
> >> Signed-off-by: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
> > 
> > The design needs to be flexible enough for different types of 
> > containers, not just for when the orchestration layer provides the 
> > policy.  With this design, the container owner has no control over 
> > the policy.
> > 
> > One option is that we bind mount the securityfs/policy, so that root 
> > in the container will be allowed to read/write the policy.  At some 
> > point, we might connect a vTPM to the container so that the 
> > container owner would be able to get a quote.  For now even without 
> > a vTPM, the same mechanism would allow root within the container to 
> > read the measurement list.
> > 
> I haven't looked at this enough yet on IMAs end, but another possible 
> solution is using a symlink and a magic jump_link similar to what nsfs is doing.
> 
> The patch series I posted out a couple of weeks ago
>   [RFC][Patch 0/3] securityfs: add the ability to support symlinks
> 
> adds symlink support to securityfs, and then patch 3/3 cribs from nsfs 
> updating apparmorfs to use jump_link to "virtualize" the apparmor 
> policy directory. This avoids needing to have the bind mount.
> 
> I'll break the patch out more and repost so its easier to see if this 
> approach might work for IMA.

Sorry, I've been meaning to take a look at your patches, but just haven't gotten to it yet. ??This approach sounds really promising.

thanks,

Mimi

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
