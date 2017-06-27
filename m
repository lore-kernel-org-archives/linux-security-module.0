From: paul@paul-moore.com (Paul Moore)
Date: Tue, 27 Jun 2017 07:58:52 -0400
Subject: The secmark "one user" policy
In-Reply-To: <20170627125138.6601452b@d-jobol.iot.bzh>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<118c3a45-8587-5cb9-fcd8-5cd8ca63a779@schaufler-ca.com>
	<alpine.LRH.2.20.1706231309350.17128@namei.org>
	<734c4437-866b-ef10-0e1c-14b8d55dd528@schaufler-ca.com>
	<alpine.LRH.2.20.1706251939510.13345@namei.org>
	<bececb1e-5913-7fec-bbdd-ca8d2033d77f@schaufler-ca.com>
	<20170626095428.4c27fc71@d-jobol.iot.bzh>
	<c99dfbd5-97e2-8122-52b5-21a972768182@schaufler-ca.com>
	<20170627125138.6601452b@d-jobol.iot.bzh>
Message-ID: <CAHC9VhRs06pWwHJAOPPU4YaaXrx=4L7N7VUrS9TWBRAtUDXPDQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 27, 2017 at 6:51 AM, Jos? Bollo <jobol@nonadev.net> wrote:
> On Mon, 26 Jun 2017 08:10:44 -0700
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> On 6/26/2017 12:54 AM, Jos? Bollo wrote:
>> > On Sun, 25 Jun 2017 11:05:24 -0700
>> > Casey Schaufler <casey@schaufler-ca.com> wrote:
>> >
>> >> On 6/25/2017 2:41 AM, James Morris wrote:
>> >>> On Fri, 23 Jun 2017, Casey Schaufler wrote:
>> >>>
>> >>>> On 6/22/2017 8:12 PM, James Morris wrote:
>> >>>>> On Thu, 22 Jun 2017, Casey Schaufler wrote:
>> >>>>>
>> >>>>>> The combination of SELinux, Smack, AppArmor and/or TOMOYO is
>> >>>>>> not the goal so much as the test case. MAC was the coolest
>> >>>>>> possible technology in 1990. We've implemented it. I don't see
>> >>>>>> anyone doing a new MAC implementation. I *do* see security
>> >>>>>> modules that implement other security models in the pipeline.
>> >>>>>> Some of these need to maintain state, which means using
>> >>>>>> security blobs in the LSM architecture. Some of these models
>> >>>>>> will want to use secmarks to implement socket based
>> >>>>>> controls.
>> >>>>> Where are these LSMs and where are the discussions about their
>> >>>>> LSM API needs?
>> >>>> LandLock, CaitSith, LoadPin (now in), Checmate, HardChroot,
>> >>>> PTAGS, SimpleFlow, SafeName, WhiteEgret, shebang, and S.A.R.A.
>> >>>> have all been discussed on the LSM list in the past two
>> >>>> years.
>> >>> Which of these need to use secmarks to implement socket
>> >>> controls?
>> >> PTAGS doesn't, but will need to do so to be complete.
>> > Hello Casey,
>> >
>> > The very sleepy PTAGS is suddently awaken (at least one ear :^).
>> >
>> > In my mind, PTAGS is dealing with processes. When packets are
>> > filtered, the only revelent info is the emitter process. At the
>> > moment, I don't see valuable situation where mediation isn't
>> > explicit thus faking origin isn't needed.
>> >
>> > So I would really like to understand your vision here. What do I
>> > miss?
>>
>> My thought is that getting the tags of the process on the other
>> end of a network connection seems like a valuable facility.
>
> I can see 3 objections: (1) secmark isn't really interesting for
> transmitting hierachical strings; (2) maintaining 2 or more remotes in
> a coherent state implies more than implicit assumptions; (3) never
> trust the network.

A point of clarification: the secmark labels are not communicated
across the network, they are assigned to packets based on the local
netfilter configuration.

A simple example with SELinux/secmark:

 # iptables -t mangle -A INPUT --src 192.168.0.16 \
   -p tcp --dport 22 -j SECMARK \
   --selctx system_u:object_r:foo_ssh_packet_t:s0

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
