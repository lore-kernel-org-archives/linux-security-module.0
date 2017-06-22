From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 22 Jun 2017 15:40:34 -0700
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <20170622210925.GA32691@mail.hallyn.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<70a09f1b-e82c-a25c-9325-d5d757b1b695@schaufler-ca.com>
	<10fb9c1b-e9af-336c-9a1b-cf95259cfaf3@linux.vnet.ibm.com>
	<2bf08b3e-27f4-3592-d5e2-a823401ac644@schaufler-ca.com>
	<20170622210925.GA32691@mail.hallyn.com>
Message-ID: <45e59e2e-0e00-cb9a-2f85-dc4606338a08@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/22/2017 2:09 PM, Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey at schaufler-ca.com):
>> On 6/22/2017 1:12 PM, Stefan Berger wrote:
>>> On 06/22/2017 03:59 PM, Casey Schaufler wrote:
>>>> On 6/22/2017 11:59 AM, Stefan Berger wrote:
>>>>> This series of patches primary goal is to enable file capabilities
>>>>> in user namespaces without affecting the file capabilities that are
>>>>> effective on the host. This is to prevent that any unprivileged user
>>>>> on the host maps his own uid to root in a private namespace, writes
>>>>> the xattr, and executes the file with privilege on the host.
>>>>>
>>>>> We achieve this goal by writing extended attributes with a different
>>>>> name when a user namespace is used. If for example the root user
>>>>> in a user namespace writes the security.capability xattr, the name
>>>>> of the xattr that is actually written is encoded as
>>>>> security.capability at uid=1000 for root mapped to uid 1000 on the host.
>>>> You need to identify the instance of the user namespace for
>>>> this to work right on a system with multiple user namespaces.
>>>> If I have a shared filesystem mounted in two different user
>>>> namespaces a change by one will affect the other.
>>> Two different user namespaces with different uid mappings will not affect each other.
>> But two namespaces with the same uid mapping will, and I
>> don't think this meets the principle of least astonishment.
> It does.  If you have one filesystem shared among multiple
> containers, then it needs to be either read-only, or you
> need to know what you're doing.

Joe's a junior devop who has been given a container
template which he tweaks for various nefarious purposes.
He doesn't know much about what he's doing. He isn't
changing the UIDs the template uses because, quite frankly,
he doesn't know a UID from an entrenching tool. He has
changed a filesystem from RO to RW because he read on a
forum somewhere that doing so would fix a problem he had
once. He doesn't want to have that problem again, so he
left the change in the template.

Containers are being sold as a way to make things easier.
This sort of side effect is dangerous in an environment
where users are being told that they don't have to worry
so much, the environment will take care of them. 

>> I also object to associating capabilities with UIDs. The
>> whole point of capabilities is to disassociate UID 0 from
>> privilege. What you've done is explicitly associate a UID
>> with the ability to have privilege. That's an architectural
>> regression.
> IMO this is looking at it the wrong way.

The right way to look at the problem is to identify the
capabilities the program ought to have and set the file
capabilities and UID/GID properly on the program on the
base system. If you have to fix the program so it works
right under those conditions, so much the better for
everyone. If you're running with different capabilities
in a container to prevent the program from doing damage
to the base system, maybe the program needs fixing instead.

> From inside the container's
> viewpoint, the capabilities are not associated with a uid.  Any
> task, regardles off uid, in the container, which executes the file,
> gets the privilege.  IMO that satisfies the intent of file capabilities.

The UID is the wrong association. The namespace is the correct association.
You're using the UID because it's something that's different in the
namespace than in the base system. You can detect it. What you need is a
non-volatile namespace id to attach to the file rather than using the
UID mapping (which may not be unique) that the namespace uses.

> -serge

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
