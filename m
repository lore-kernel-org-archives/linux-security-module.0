From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 00:36:59 -0700
Subject: [RFC 04/11] ima: add support to namespace securityfs file
In-Reply-To: <1495656774.3841.72.camel@linux.vnet.ibm.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
	<1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
	<1495656774.3841.72.camel@linux.vnet.ibm.com>
Message-ID: <d8d55872-db78-3535-a540-85c0dbb2d6fd@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/24/2017 01:12 PM, Mimi Zohar wrote:
> On Thu, 2017-05-11 at 10:59 -0300, Guilherme Magalhaes wrote:
>> Creating the namespace securityfs file under ima folder. When a mount
>> namespace id is written to the namespace file, a new folder is created and
>> with a policy file for that specified namespace. Then, user defined policy
>> for namespaces may be set by writing rules to this namespace policy file.
>> With this interface, there is no need to give visibility for the securityfs
>> inside mount namespaces or containers in userspace.
>>
>> Signed-off-by: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
> 
> The design needs to be flexible enough for different types of
> containers, not just for when the orchestration layer provides the
> policy.  With this design, the container owner has no control over the
> policy.
> 
> One option is that we bind mount the securityfs/policy, so that root
> in the container will be allowed to read/write the policy.  At some
> point, we might connect a vTPM to the container so that the container
> owner would be able to get a quote.  For now even without a vTPM, the
> same mechanism would allow root within the container to read the
> measurement list.
> 
I haven't looked at this enough yet on IMAs end, but another possible solution
is using a symlink and a magic jump_link similar to what nsfs is doing.

The patch series I posted out a couple of weeks ago
  [RFC][Patch 0/3] securityfs: add the ability to support symlinks

adds symlink support to securityfs, and then patch 3/3 cribs from nsfs
updating apparmorfs to use jump_link to "virtualize" the apparmor policy
directory. This avoids needing to have the bind mount.

I'll break the patch out more and repost so its easier to see if this
approach might work for IMA.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
