From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Mon, 3 Apr 2017 13:25:18 -0700 (PDT)
Subject: [PATCH v13 00/10] Make keyring link restrictions accessible from
	userspace
In-Reply-To: <3861.1491235163@warthog.procyon.org.uk>
References: <25508.1491233084@warthog.procyon.org.uk>
	<20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
	<3861.1491235163@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.21.1704031317130.6711@mjmartin-mac01.local>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On Mon, 3 Apr 2017, David Howells wrote:

> David Howells <dhowells@redhat.com> wrote:
>
>> I've just updated my keys-blacklist and keys-next branches to security/next.
>> Could you rebase on that so that I can pull it?  There shouldn't be any need
>> to repost your patches unless you need to make changes.
>
> Rebasing on security/next would also do if your patches don't depend on my
> blacklist patches.

Thanks, David. The rebase did not have any conflicts, so I have not made 
changes to the posted patches.

You can pull from the keyctl-restrict branch of
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
(commit id c06c4d85cc986688c8f7e510412485ab4422a334)

--
Mat Martineau
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
