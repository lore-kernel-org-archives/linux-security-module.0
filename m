From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 26 Apr 2018 17:46:39 -0700
Subject: Extracting written string from the write syscall
In-Reply-To: <CAMp4zn9nFDPA0-FU7us3dKQyz3vfYDOTQJ6fuJutips2CoGbOg@mail.gmail.com>
References: <CAH5sRbr_-nHPb8moqPyZ--JVOzGi+_PHVVteA+TXe-Yqaoa5xA@mail.gmail.com>
	<20180426185725.4a53fa47@ivy-bridge>
	<1dfb37cb-b440-a3da-c6e2-c328d43ffa5a@schaufler-ca.com>
	<CAMp4zn9nFDPA0-FU7us3dKQyz3vfYDOTQJ6fuJutips2CoGbOg@mail.gmail.com>
Message-ID: <5816af1d-8409-64e5-f1de-e4211defacc7@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/26/2018 5:08 PM, Sargun Dhillon wrote:
> On Thu, Apr 26, 2018 at 4:40 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/26/2018 3:57 PM, Steve Grubb wrote:
>>> On Thu, 26 Apr 2018 20:34:57 +0000
>>> Wajih Ul Hassan <wajih.lums@gmail.com> wrote:
>>>
>>>> Hi all,
>>>>  .....
>> You could write a Linux Security Module (LSM) to monitor the
>> content of writes. The performance impact would be rather
>> amazing.
>>
> I would recommend using BPF + kprobes + perf_event buffers for this
> purpose. There are enough places you can probe to grab these strings
> in the kernel, and if you do your filtering in BPF, you can then push
> it into kernel space based on filtering. Although, AFAIK, the BPF JITs
> don't do vectorization of instructions, but it's still not too bad. If
> you put your kprobe on the syscall itself, and probe the userspace
> addr, remember you're going to be open to a time-of-use, time-of-check
> style attack.

That looks like a whole lot of mechanism to perform a simple task.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
