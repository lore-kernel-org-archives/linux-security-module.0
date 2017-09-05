From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue, 5 Sep 2017 15:16:57 +0300
Subject: [PATCH v7 00/19] simplify crypto wait for async op
In-Reply-To: <CAFXBA=mqYxD3H_e38hEd2hVL4yvPXb_4DnfgGO5bf6YboTQVSg@mail.gmail.com>
References: <1503584350-7831-1-git-send-email-gilad@benyossef.com>
	<CAFXBA=n6W_n1P=NKHEUAgpaDDrdmh4QwB4aYma9xyio7UFP3Vw@mail.gmail.com>
	<CAOtvUMcjtEMj4eoCG_Rpp-8CmJP+Yu0dPDN3PyOTWjHapf_y1g@mail.gmail.com>
	<CAFXBA=mqYxD3H_e38hEd2hVL4yvPXb_4DnfgGO5bf6YboTQVSg@mail.gmail.com>
Message-ID: <CAOtvUMdrMEPjXqVk66EOM+2NYoU-Hze2+5Vx6HGuR4FDNxYzDQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 5, 2017 at 2:23 PM, Harsh Jain <harshjain.prof@gmail.com> wrote:
> On Sun, Sep 3, 2017 at 11:47 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> On Thu, Aug 31, 2017 at 3:31 PM, Harsh Jain <harshjain.prof@gmail.com> wrote:
>>> HI Gilad,
>>>
>>> I think we need an update in ESP also. Now EBUSY return means driver
>>> has accepted, Packet should not be dropped in
>>>
>>> esp_output_tail() function.
>>
>> Good catch. You are right and the same holds true for ah_output() in ah4.c.
>>
>> But I do wonder, the code there now treats -EBUSY as a special case
>> and returns NET_XMIT_DROP
>> but if an AEAD or AHASH transformation return some other error, like
>> -ENOMEM or -EINVAL shouldn't
>> we return NET_XMIT_DROP in that case too?
> I think we should not,  XMIT_DROP implies drop current packet only,
> later on when device is recovered from busy state, Upper layer
> protocol(TCP) will re-transmit the packet. It helps in flow control.
>>

I see. Makes sense.

Thanks,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
