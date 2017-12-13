From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 13 Dec 2017 13:38:37 +0100
Subject: [RFC v2 1/3] security: Add safe,
	dynamic (runtime-loadable) hook support
In-Reply-To: <alpine.LFD.2.20.1712110923210.19397@localhost>
References: <cover.1512704909.git.sargun@netflix.com>
	<5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
	<alpine.LFD.2.20.1712110923210.19397@localhost>
Message-ID: <CAMp4zn89NoTKy9=Ek1FEsv22bGhZb0qCUwT11_+unY2LskBDPQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Dec 10, 2017 at 11:28 PM, James Morris
<james.l.morris@oracle.com> wrote:
> On Fri, 8 Dec 2017, Sargun Dhillon wrote:
>
>> The primary purpose of this patchset is to facilitate the development of
>> out-of-tree minor LSMs.
>
> This is not a valid use-case for the mainline kernel: we don't add
> features for out of tree code.
>
> Please reconsider your rationale :-)
>
>
> - James
> --
> James Morris
> <james.l.morris@oracle.com>
>
Even a la livepatch? One of our primary usecases is for a safer
version of livepatch, with simpler consistency guarantees. The model
is to be able to generate a module that targets a specific CVE, and
roll it out via DKMS, or similar to a heterogenous fleet.

The other one is to be able to dynamically compile LSMs a la
systemtap, using a DSL. One of the biggest problems we've seen is that
the capability of LSMs is limited by the policy. Changing the policy
requires in-kernel changes, whereas a compiler in userspace is
significantly easier to modify.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
