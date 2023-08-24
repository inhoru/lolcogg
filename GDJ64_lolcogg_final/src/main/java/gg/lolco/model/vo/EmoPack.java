package gg.lolco.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmoPack {
	private int emoPackNo;
	private Emoticon emoNo;
	private PointItem itemNo;
}
